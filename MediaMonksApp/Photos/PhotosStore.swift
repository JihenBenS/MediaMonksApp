import Foundation
import SwiftUI
import Accelerate

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
}
