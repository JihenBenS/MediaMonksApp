import UIKit

protocol ViewFactory {
    func mainView(router: AlbumsRouterProtocol) -> MainView
    func photosListView(viewModel: PhotosViewModel) -> PhotosListView
    func photoDetailsView(viewModel: PhotoDetailsViewModel) -> PhotoDetailsView
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

    func photoDetailsView(viewModel: PhotoDetailsViewModel) -> PhotoDetailsView {
        let presenter = PhotoDetailsPresenter()
        let store = PhotoDetailsStore(viewModel: viewModel,
                                      presenter: presenter)
        return PhotoDetailsView(store: store)
    }
}
