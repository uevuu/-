//
//  Product.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let sellerName: String
    let price: Int
    let categoryId: Int
    let quantity: Int
    let description: String
    let image: String
    let moreImages: [String]
}
