//
//  CartViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import Foundation

// MARK: - CartViewInput
protocol CartViewInput: AnyObject {
    func reloadCart()
}

// MARK: - CartViewOutput
protocol CartViewOutput: AnyObject {
    func viewDidLoadEvent()
    func deinitEvent()
    func getItemsInCartCount() -> Int
    func configureCell(_ cell: ProductInCartTableViewCell, at indexPath: IndexPath)
    func deleteSelected()
    func selectAll()
    func selectProduct(at index: Int)
    func deleteProduct(at index: Int)
    func selectCount(at index: Int)
    func selectProduct(at indexPath: IndexPath)
    func proceedToCheckout()
}
