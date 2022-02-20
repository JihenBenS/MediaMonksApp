import Foundation
import Combine

protocol AlbumsPresenterProtocol: AnyObject {
    func fetchAlbums()
    var albumsPublisher: CurrentValueSubject<AlbumsViewModel.Content, Error> { get }
}

class AlbumsPresenter: AlbumsPresenterProtocol {
    var albumsPublisher: CurrentValueSubject<AlbumsViewModel.Content, Error>
    
    private var cancellables: Set<AnyCancellable> = []

    private let router: AlbumsRouterProtocol
    private let interactor: AlbumsInteractorProtocol
    
    init(interactor: AlbumsInteractorProtocol,
         router: AlbumsRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.albumsPublisher = CurrentValueSubject(AlbumsViewModel.Content(elements: []))
    }
}

extension AlbumsPresenter {

    func fetchAlbums() {
        interactor.fetchAlbums()
        interactor.albumsPublisher
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.albumsPublisher.send(completion: .failure(error))
                case .finished:
                    self?.albumsPublisher.send(completion: .finished)
                }
            } receiveValue: { [weak self] albums in
                guard let self = self else {return}
                self.albumsPublisher.send(self.convertToViewModel(albums: albums))
            }
            .store(in: &cancellables)
    }

    func convertToViewModel(albums: [Album]) -> AlbumsViewModel.Content {
        let elements = albums.map{
            AlbumViewModel(album: $0)
        }
        return AlbumsViewModel.Content(elements: elements)
    }
}
