import Foundation
import Combine

enum NetworkingError: Error {
    case badURL
    case notFound
    case decodeError
    case unexpected(code: Int)
}

protocol AlbumServiceProtocol: AnyObject {
    func fetchAlbums() -> AnyPublisher<[Album], Error>
    func fetchAlbum(id: Int) -> AnyPublisher<Album, Error>
}

class AlbumService: AlbumServiceProtocol {
    
    func fetchAlbums() -> AnyPublisher<[Album], Error> {
        
        let urlComponents = URLComponents(string: Constants.Routes.baseURL.absoluteString)!

        guard let url = urlComponents.url else {
            return Future<[Album], Error>(){ promise in
                promise(Result.failure(NetworkingError.badURL))
            }.eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: [Album].self, decoder: JSONDecoder())
            .catch { error in
                Future<[Album], Error>(){ promise in
                    promise(Result.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }

    func fetchAlbum(id: Int) -> AnyPublisher<Album, Error> {
        
        let urlComponents = URLComponents(string: Constants.Routes.baseURL.absoluteString)!

        guard let url = urlComponents.url else {
            return Future<Album, Error>(){ promise in
                promise(Result.failure(NetworkingError.badURL))
            }.eraseToAnyPublisher()
        }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: Album.self, decoder: JSONDecoder())
            .catch { error in
                Future<Album, Error>(){ promise in
                    promise(Result.failure(error))
                }
            }.eraseToAnyPublisher()
        return publisher
    }
}

