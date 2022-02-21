import Foundation
import SwiftUI

class PhotoDetailsStore: ObservableObject {
    private var presenter: PhotoDetailsPresenterProtocol
    @Published var viewModel: PhotoDetailsViewModel

    init(viewModel: PhotoDetailsViewModel,
        presenter: PhotoDetailsPresenterProtocol) {
        self.presenter = presenter
        self.viewModel = viewModel
        formatData()
    }

    func formatData() {
        viewModel.stringDate = presenter.getStringDate(from: viewModel.unixTimestampDate)
        Task {
            viewModel.address = await presenter.getAddressFromLatLon(latitude: viewModel.lat,
                                                                     longitude: viewModel.long)
        }
    }
}
