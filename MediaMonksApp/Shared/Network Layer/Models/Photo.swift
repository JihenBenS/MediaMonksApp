struct Photo: Codable {
    let id: Int
    let photoUrl: String
    let date: Int
    let latitude, longitude: Double?
    let photoDescription: String

    enum CodingKeys: String, CodingKey {
        case id
        case photoUrl
        case date
        case latitude
        case longitude
        case photoDescription = "description"
    }
}
