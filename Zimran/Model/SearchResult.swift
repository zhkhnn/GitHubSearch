import Foundation

struct SearchResult: Decodable {
    var total_count: Int?
    var items: [Repository]?

    enum CodingKeys: String, CodingKey {
        case total_count
        case items
    }
}
