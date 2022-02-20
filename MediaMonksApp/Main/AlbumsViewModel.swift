import Foundation

struct AlbumsViewModel {
    struct Content {
        let elements: [AlbumViewModel]
    }

    enum State {
        case loading
        case content(Content)
        case error(String)
    }
    var state: State

    var albums: [AlbumViewModel] {
        if case .content(let content) = state {
            return content.elements
        } else {
            return []
        }
    }

    var albumsCount: Int {
        if case .content(let content) = state {
            return content.elements.count
        } else {
            return 0
        }
    }
}

public class AlbumViewModel: Equatable, Identifiable {

    public static func == (lhs: AlbumViewModel, rhs: AlbumViewModel) -> Bool {
        return lhs.name == rhs.name &&
        lhs.cover == rhs.cover
    }
    
    let album: Album
    init(album: Album) {
        self.album = album
    }

    var name: String {
        return album.name
    }

    var cover: String {
        return album.coverUrl
    }

    var photos: [Photo] {
        if let photos = album.photos {
            return photos
        } else {
            return []
        }
    }

    var photosCount: Int {
        if let photos = album.photos {
            return photos.count
        } else {
            return 0
        }
    }
}
