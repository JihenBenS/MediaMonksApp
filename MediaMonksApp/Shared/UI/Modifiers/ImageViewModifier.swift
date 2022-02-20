import SwiftUI

struct ImageGradiantModifier: ViewModifier {
    let title: String
    let photosCount: Int

    func body(content: Content) -> some View {
        ZStack {
            content
            LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .center)
            VStack(alignment: .center, spacing: 4) {
                Spacer()
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .modifier(AppStandardFont(size: 20))
                Text("\(photosCount) pictures")
                    .foregroundColor(.white)
                    .modifier(AppStandardFont(size: 14))
            }
            .padding()
        }
    }
}
