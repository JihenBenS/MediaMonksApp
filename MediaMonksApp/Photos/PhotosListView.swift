import SwiftUI

struct PhotosListView: View {
    @StateObject var store: PhotosStore
    let headerFontSize: CGFloat = 48
    let columns = [
        GridItem(.adaptive(minimum: 200), spacing: 28)
    ]

    var body: some View {
        NavigationView {
            VStack() {
                Text(store.viewModel.albumTitle)
                    .foregroundColor(Color("primary"))
                    .modifier(CurlyFont(size: headerFontSize))
                    .multilineTextAlignment(.leading)
                    .padding([.bottom, .top], 8)
                ScrollView(showsIndicators: false) {
                    LazyVGrid (columns: columns, spacing: 28) {
                        ForEach(store.viewModel.photos) { element in
                            Text(element.stringDate ?? "- No Date -")
                                .bold()
                            ImageFetcher(urlImage: element.photoUrl)
                                .frame(maxHeight: 280)
                                .cornerRadius(12)
                            }
                    }
                    .padding([.bottom, .top], 16)
                }
            }
            .padding([.trailing, .leading], 36)
            .padding(.top, -60)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(Color("brightPink"))
    }
}
