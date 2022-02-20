struct Album: Codable {
    let id: Int
    let name: String
    let coverUrl: String
    let photos: [Photo]?
}
