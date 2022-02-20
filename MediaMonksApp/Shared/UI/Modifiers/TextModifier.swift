import SwiftUI

struct AppStandardFont: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica Neue", size: size))
    }
}

struct CurlyFont: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom("Cookie-Regular", size: size))
    }
}
