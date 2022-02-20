import SwiftUI

@main
struct MediaMonksApp: App {
    var body: some Scene {
        WindowGroup {
            let viewFactory = SwiftUIFactory()
            let albumsRouter = AlbumsRouter(viewFactory: viewFactory)
            let view = viewFactory.mainView(router: albumsRouter)
            view
        }
    }
}
