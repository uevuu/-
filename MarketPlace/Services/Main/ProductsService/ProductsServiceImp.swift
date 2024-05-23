//
//  ProductsServiceImp.swift
//  MarketPlace
//
//  Created by Nikita Marin on 13.10.2023.
//

// MARK: - ProductsServiceImp
final class ProductsServiceImp: ProductsService {
    private let networkService = NetworkService()
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.sendGetRequest(
            endpoint: "/products",
            completion: completion
        )
    }
    
    func getSellerProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        networkService.sendGetRequest(
            endpoint: "/sellers/12/products",
            completion: completion)
    }
}
