import Foundation
import Combine

class AlbumsStore: ObservableObject {
    private var presenter: AlbumsPresenterProtocol
    @Published var viewModel: AlbumsViewModel

    var cancellable: AnyCancellable?

    init(presenter: AlbumsPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = AlbumsViewModel(state: .loading)
        fetchAlbums()
    }

    func fetchAlbums() {
        presenter.fetchAlbums()
        cancellable = presenter.albumsPublisher
            .sink {[weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.viewModel.state = .error(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] receivedValue in
                self?.viewModel.state = .content(receivedValue)
            }
    }

    func photosListView(elements: [Photo]) -> PhotosListView {
        return presenter.photosListView(elements: elements)
    }
}
