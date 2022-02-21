import SwiftUI

struct MainView: View {
    @StateObject var store: AlbumsStore
    let headerFontSize: CGFloat = 48
    let iconSize: CGFloat = 48

    let columns = [
        GridItem(.adaptive(minimum: 140), spacing: 28)
    ]

    var body: some View {
        NavigationView {
            VStack {
                // MARK: View Header
                HStack(alignment: .center, spacing: 10) {
                    Text("My Collection")
                        .foregroundColor(Color("primary"))
                        .modifier(CurlyFont(size: headerFontSize))
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Button(action: {
                        print("Go to all photos")
                    }, label: {
                        Image("photosIcon")
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                            .foregroundColor(Color("brightPink"))
                    })
                }
                .padding(.top, 24)
                // MARK: Albums Display
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 28) {
                        ForEach(store.viewModel.albums) { element in
                            NavigationLink(destination: store.photosListView(albumTitle: element.name, elements: element.photos)) {
                                ImageFetcher(urlImage: element.cover)
                                .modifier(ImageGradiantModifier(title: element.name,
                                                                photosCount: element.photosCount))
                                .frame(maxHeight: 180)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding([.bottom, .top], 16)
                }
            }
            .padding([.trailing, .leading], 36)
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(Color("brightPink"))
    }
}
