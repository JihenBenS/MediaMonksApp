import Foundation
import Combine
@testable import MediaMonksApp

class FakeService: AlbumServiceProtocol {
    func fetchAlbums() -> AnyPublisher<[Album], Error> {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "Mock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let albums = try JSONDecoder().decode([Album].self, from: data)
                return Future<[Album], Error> { promise in
                    promise(.success(albums))
                }.eraseToAnyPublisher()

            } catch {
                return Future<[Album], Error> { promise in
                    promise(.failure(error))
                }.eraseToAnyPublisher()
            }
        } else {
            return Future<[Album], Error> { promise in
                promise(.failure(NetworkingError.notFound))
            }.eraseToAnyPublisher()
        }
    }

    func fetchAlbum(id: Int) -> AnyPublisher<Album, Error> {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let album = try JSONDecoder().decode(Album.self, from: data)
                return Future<Album, Error> { promise in
                    promise(.success(album))
                }.eraseToAnyPublisher()

            } catch {
                return Future<Album, Error> { promise in
                    promise(.failure(error))
                }.eraseToAnyPublisher()
            }
        } else {
            return Future<Album, Error> { promise in
                promise(.failure(NetworkingError.notFound))
            }.eraseToAnyPublisher()
        }
    }
}
