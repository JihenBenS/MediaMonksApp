import Foundation

protocol PhotosRouterProtocol: AnyObject {
}

class PhotosRouter: PhotosRouterProtocol {

    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
}
