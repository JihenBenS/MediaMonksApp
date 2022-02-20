import Foundation
import Accelerate

protocol AlbumsRouterProtocol: AnyObject {
}

class AlbumsRouter: AlbumsRouterProtocol {

    private let viewFactory: ViewFactory
    
    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }
}
