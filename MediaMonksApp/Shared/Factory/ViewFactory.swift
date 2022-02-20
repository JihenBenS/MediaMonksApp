import UIKit

protocol ViewFactory {
    func mainView(router: AlbumsRouterProtocol) -> MainView
    func photosListView(viewModel: PhotosViewModel) -> PhotosListView
}

class SwiftUIFactory: ViewFactory {
    func mainView(router: AlbumsRouterProtocol) -> MainView {
        let albumService = AlbumService()
        let interactor = AlbumsInteractor(albumsService: albumService)
        let presenter = AlbumsPresenter(interactor: interactor, router: router)
        let store = AlbumsStore(presenter: presenter)
        return MainView(store: store)
    }

    func photosListView(viewModel: PhotosViewModel) -> PhotosListView {
        return PhotosListView()
    }
}
