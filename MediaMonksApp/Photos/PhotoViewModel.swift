import Foundation

struct PhotosViewModel {
    let albumTitle: String
    var photos: [PhotoViewModel]
}

public class PhotoViewModel: Equatable, Identifiable {

    public static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
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

    var stringDate: String?
}
