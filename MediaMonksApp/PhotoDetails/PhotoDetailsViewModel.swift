import SwiftUI

public class PhotoDetailsViewModel: Equatable, Identifiable {

    public static func == (lhs: PhotoDetailsViewModel, rhs: PhotoDetailsViewModel) -> Bool {
        return lhs.photoUrl == rhs.photoUrl &&
        lhs.unixTimestampDate == rhs.unixTimestampDate
    }

    let photo: Photo
    init(photo: Photo) {
        self.photo = photo
    }

    var photoUrl: String {
        return photo.photoUrl
    }

    var unixTimestampDate: Int {
        return photo.date
    }

    var lat: Double? {
        return photo.latitude
    }

    var long: Double? {
        return photo.longitude
    }

    var photoDescription: String? {
        return photo.photoDescription
    }

    var stringDate: String?
    var address: String?
    var image: UIImage?
    var imageSize: String?
}
