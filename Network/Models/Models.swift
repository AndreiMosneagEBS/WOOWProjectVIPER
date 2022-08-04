//
//  Models.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 28.07.2022.
//

// MARK: - Products
struct ProductsResults: Codable {
    let count, totalPages, perPage, currentPage: Int?
    let results: [About]?

    enum CodingKeys: String, CodingKey {
        case count
        case totalPages = "total_pages"
        case perPage = "per_page"
        case currentPage = "current_page"
        case results
    }
}

// MARK: - Result
struct About: Codable {
    let category: Category?
    let name, details, size, colour: String?
    let price: Int?
    let mainImage: String?
    let id: Int?
    
    enum CodingKeys: String, CodingKey {
        case category, name, details, size, colour, price
        case mainImage = "main_image"
        case id
    }
}


// MARK: - Category
struct Category: Codable {
    let name: String?
    let icon: String?
    let id: Int?
}



struct ProductDetails: Decodable {
    let category: AboutProduct?
    let name, details, size, colour: String?
    let price, id: Int?
    let mainImage: String?
    let images: [Image]?
    let reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case category, name, details, size, colour, price, id
        case mainImage = "main_image"
        case images, reviews
    }
}

// MARK: - Category
struct AboutProduct: Codable, Equatable {
    let name: String?
    let icon: String?
    let id: Int?
}

// MARK: - Image
struct Image: Codable {
    let image: String?
}

// MARK: - Review
struct Review: Codable {
    let id: Int?
    let modifiedAt, createdAt, firstName, lastName: String?
    let image: String?
    let rating: Int?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case id
        case modifiedAt = "modified_at"
        case createdAt = "created_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case image, rating, message
    }
}

