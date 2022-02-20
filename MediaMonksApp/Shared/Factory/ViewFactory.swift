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
        let router = PhotosRouter(viewFactory: SwiftUIFactory())
        let presenter = PhotosPresenter(router: router)
        let store = PhotosStore(viewModel: viewModel,
                                presenter: presenter)
        return PhotosListView(store: store)
    }
}
