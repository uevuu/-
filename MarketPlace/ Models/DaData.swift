//
//  DaData.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import Foundation

struct PopulatedAreas: Codable {
    let suggestions: [Area]
}

struct Area: Codable {
    let value: String
    let data: AreaData
}

struct AreaData: Codable {
    let postalCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case postalCode = "postal_code"
    }
}
