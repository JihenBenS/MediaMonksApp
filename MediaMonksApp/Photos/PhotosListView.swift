import SwiftUI

struct PhotosListView: View {
    @StateObject var store: PhotosStore
    let headerFontSize: CGFloat = 48
    let columns = [
        GridItem(.adaptive(minimum: 200), spacing: 28)
    ]

    var body: some View {
        VStack() {
            Text(store.viewModel.albumTitle)
                .foregroundColor(Color("primary"))
                .modifier(CurlyFont(size: headerFontSize))
                .multilineTextAlignment(.leading)
                .padding([.bottom, .top], 8)
            ScrollView(showsIndicators: false) {
                LazyVGrid (columns: columns, spacing: 28) {
                    ForEach(store.viewModel.photos) { element in
                        NavigationLink(destination: store.photoDetailsView(photo: element.photo)) {
                            ImageFetcher(urlImage: element.photoUrl)
                                .frame(maxHeight: 280)
                                .cornerRadius(12)
                            }
                        Text(element.stringDate ?? "- No Date -")
                            .bold()
                        }
                }
                .padding([.bottom, .top], 16)
            }
            .padding([.trailing, .leading], 36)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(Color("brightPink"))
    }
}
