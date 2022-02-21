import SwiftUI

struct PhotoDetailsView: View {
    @StateObject var store: PhotoDetailsStore
    let fontSize: CGFloat = 16
    let iconSize: CGFloat = 24

    var body: some View {
        createImageDetails(stringDate: store.viewModel.stringDate ?? "No date",
                           address: store.viewModel.address ?? "Location unknown",
                           description: store.viewModel.photoDescription ?? "")
        .padding(.top, 24)
        .padding([.trailing, .leading], 36)
    }

    @ViewBuilder func createImageDetails(stringDate: String, address: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 32) {
            ImageFetcher(urlImage: store.viewModel.photoUrl)
                .cornerRadius(8)
                .scaledToFit()
            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                    Text(stringDate)
                        .modifier(AppStandardFont(size: fontSize))
                }
                HStack() {
                    Image(systemName: "location.square")
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                    Text(address)
                        .modifier(AppStandardFont(size: fontSize))
                }
                HStack() {
                    Image(systemName: "list.bullet.rectangle")
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                    Text(description)
                        .modifier(AppStandardFont(size: fontSize))
                }
            }
            Spacer()
        }
    }
}
