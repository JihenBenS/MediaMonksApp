import SwiftUI
import Kingfisher

@available(iOS 14.0, *)
struct ImageFetcher: View {
    let urlImage: String
    @State var progress: Float = 0

    init(urlImage: String) {
        self.urlImage = urlImage
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: urlImage)!)
                .cacheOriginalImage()
                .onFailure { e in
                    print("error: \(e)")
                }
                .resizable()
        }
    }
}
