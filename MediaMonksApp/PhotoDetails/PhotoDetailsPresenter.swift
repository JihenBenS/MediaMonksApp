import CoreLocation
import UIKit
import Kingfisher

protocol PhotoDetailsPresenterProtocol: AnyObject {
    func getStringDate(from unixTimestampDate: Int) -> String
    func getAddressFromLatLon(latitude: Double?, longitude: Double?) async -> String
}

class PhotoDetailsPresenter: PhotoDetailsPresenterProtocol {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd MMMM yyyy - hh:mm"
        return dateFormatter
    }()

    func getStringDate(from unixTimestampDate: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestampDate))
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    func getAddressFromLatLon(latitude: Double?, longitude: Double?) async -> String {
        var addressString: String = ""
        guard let latitude = latitude, let longitude = longitude else {
            return ""
        }

        var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = latitude
        center.longitude = longitude

        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)

        do {
            let placemarks = try await ceo.reverseGeocodeLocation(loc)
            if placemarks.count > 0 {
                let pm = placemarks[0]
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country!
                }
            }
            return addressString
        } catch {
            debugPrint(error.localizedDescription)
            return ""
        }
    }
}
