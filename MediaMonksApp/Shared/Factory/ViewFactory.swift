import UIKit

protocol ViewFactory {
    func mainView(router: AlbumsRouterProtocol) -> MainView
}

class SwiftUIFactory: ViewFactory {
    func mainView(router: AlbumsRouterProtocol) -> MainView {
        let albumService = AlbumService()
        let interactor = AlbumsInteractor(albumsService: albumService)
        let presenter = AlbumsPresenter(interactor: interactor, router: router)
        let store = AlbumsStore(presenter: presenter)
        return MainView(store: store)
    }
}
