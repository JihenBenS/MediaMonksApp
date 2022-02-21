protocol PhotosRouterProtocol: AnyObject {
    func photoDetailsView(viewModel: PhotoDetailsViewModel) -> PhotoDetailsView
}

class PhotosRouter: PhotosRouterProtocol {

    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    func photoDetailsView(viewModel: PhotoDetailsViewModel) -> PhotoDetailsView {
        return viewFactory.photoDetailsView(viewModel: viewModel)
    }
}
