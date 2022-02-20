import Foundation
import Accelerate

protocol AlbumsRouterProtocol: AnyObject {
    func photosListView(viewModel: PhotosViewModel) -> PhotosListView
}

class AlbumsRouter: AlbumsRouterProtocol {

    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    func photosListView(viewModel: PhotosViewModel) -> PhotosListView {
       return viewFactory.photosListView(viewModel: viewModel)
     }
}
