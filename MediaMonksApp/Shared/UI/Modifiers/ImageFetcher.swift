import SwiftUI
import Kingfisher

@available(iOS 14.0, *)
struct ImageFetcher: View {
    let urlImage: String
    @State var content: KFCrossPlatformImage?

    init(urlImage: String) {
        self.urlImage = urlImage
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: urlImage)!)
                .cacheOriginalImage()
                .onSuccess { result in
                    content = result.image
                }
                .onFailure { e in
                    print("error: \(e)")
                }
                .resizable()
        }
    }
}
