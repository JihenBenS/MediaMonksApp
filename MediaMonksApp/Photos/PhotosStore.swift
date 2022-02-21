import SwiftUI

class PhotosStore: ObservableObject {
    private var presenter: PhotosPresenterProtocol
    @Published var viewModel: PhotosViewModel

    init(viewModel: PhotosViewModel,
        presenter: PhotosPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = viewModel
        formatData()
    }

    func formatData() {
        viewModel.photos.forEach {
            $0.stringDate = presenter.getStringDate(from: $0.unixTimestampDate)
        }
    }

    func photoDetailsView(photo: Photo) -> PhotoDetailsView {
        return presenter.photoDetailsView(photo: photo)
    }
}
