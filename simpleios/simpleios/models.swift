import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int?
    let title: String?
    let description: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let category: String?
    let thumbnail: URL?
    let images: [URL]?
}

struct ProductMeta: Codable {
    var products: [Product]
}

struct Cart: Codable {
    var CartItems: [Product]
}

struct CartMeta: Codable {
    var Carts: [Cart]
}

