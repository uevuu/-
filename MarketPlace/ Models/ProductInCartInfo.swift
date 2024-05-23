//
//  ProductInCartInfo.swift
//  MarketPlace
//
//  Created by Nikita Marin on 16.10.2023.
//

import Foundation

struct ProductInCartInfo: Codable {
    let product: Product
    let count: Int
    let addedToOrder: Bool
}
