//
//  ProductsService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

// MARK: - ProductsService
protocol ProductsService: AnyObject {
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void)
    func getSellerProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}
