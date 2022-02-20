import Foundation
import Combine

protocol AlbumsInteractorProtocol: AnyObject {
    func fetchAlbums()
    var albumsPublisher: CurrentValueSubject<[Album],Error> { get }
}

class AlbumsInteractor: AlbumsInteractorProtocol {
    private let albumsService: AlbumServiceProtocol
    
    private var cancellables: Set<AnyCancellable> = []
    
    var albumsPublisher: CurrentValueSubject<[Album], Error>
    
    init(albumsService: AlbumServiceProtocol) {
        self.albumsService = albumsService
        self.albumsPublisher = CurrentValueSubject([])
    }

    func fetchAlbums() {
        albumsService.fetchAlbums()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self?.albumsPublisher.send(completion: .failure(error))
                case .finished:
                    self?.albumsPublisher.send(completion: .finished)
                }
            } receiveValue: { response in
                self.albumsPublisher.send(response)
            }
            .store(in: &cancellables)
    }
}
