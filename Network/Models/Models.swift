//
//  Models.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 28.07.2022.
//

// MARK: - Products
struct Products: Codable {
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
