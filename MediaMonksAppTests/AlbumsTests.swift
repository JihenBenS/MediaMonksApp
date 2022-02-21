import XCTest
@testable import MediaMonksApp
import Combine

class AlbumsTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    
    func testInteractor() throws {
        let interactor = AlbumsInteractor(albumsService: FakeService())

        interactor.fetchAlbums()

        let albums = try awaitPublisher(interactor.albumsPublisher, description: "Track publisher")
        XCTAssertTrue(albums.count>0)
    }

    func testPresenter() throws {
        let interactor = AlbumsInteractor(albumsService: FakeService())
        let presenter = AlbumsPresenter(interactor: interactor, router: AlbumsRouter(viewFactory: SwiftUIFactory()))
        
        presenter.fetchAlbums()
        
        let playlist = try awaitPublisher(presenter.albumsPublisher)
        
        XCTAssertTrue(playlist.elements.count>0)
    }

    func testStore() throws {
        let interactor = AlbumsInteractor(albumsService: FakeService())
        let presenter = AlbumsPresenter(interactor: interactor, router: AlbumsRouter(viewFactory: SwiftUIFactory()))
        let store = AlbumsStore(presenter: presenter)
        
        let expectation = expectation(description: "Store")
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            XCTAssertTrue(store.viewModel.albumsCount>0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}

