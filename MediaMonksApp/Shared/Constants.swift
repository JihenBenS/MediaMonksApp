import Foundation

enum Constants {
    enum Routes {
        static let baseURL = URL(string: "https://my-json-server.typicode.com/JihenBenS/MediaMonksApp/albums")!
        static func getAlbum(id: Int) -> URL {
            return URL(string: "\(id)", relativeTo: baseURL)!
        }
    }
}
