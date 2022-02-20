import Foundation
import CoreLocation

protocol PhotosPresenterProtocol: AnyObject {
    func getStringDate(from unixTimestampDate: Int) -> String
}

class PhotosPresenter: PhotosPresenterProtocol {
    private let router: PhotosRouterProtocol
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter
    }()

    
    init(router: PhotosRouterProtocol) {
        self.router = router
    }

    func getStringDate(from unixTimestampDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestampDate))
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
