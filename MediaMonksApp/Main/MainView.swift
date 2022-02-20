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
            VStack() {
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
                ScrollView(showsIndicators: false) {
                    LazyVGrid (columns: columns, spacing: 28) {
                        ForEach(store.viewModel.albums) { element in
                                ImageFetcher(urlImage: element.cover)
                                .modifier(ImageGradiantModifier(title: element.name,
                                                                photosCount: element.photosCount))
                                .frame(maxHeight: 180)
                                .cornerRadius(12)
                        }
                    }
                    .padding([.bottom, .top], 8)
                }
            }
            .padding([.trailing, .leading], 36)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(Color("brightPink"))
    }
}
