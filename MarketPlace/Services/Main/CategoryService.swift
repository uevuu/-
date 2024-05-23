//
//  CategoryService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import Alamofire

// MARK: - CategoryService
final class CategoryService {
    private let networkService = NetworkService()
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        networkService.sendGetRequest(
            endpoint: "/categories",
            completion: completion
        )
    }
}

struct Category: Codable {
    let id: Int
    let parentId: Int?
    let title: String
}
