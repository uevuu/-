//
//  HomeViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import Foundation

// MARK: - HomeViewInput
protocol HomeViewInput: AnyObject {
    func reloadView()
}

// MARK: - HomeViewOutput
protocol HomeViewOutput: AnyObject {
    func viewDidLoadEvent()
    func getProductsCount() -> Int
    func configureCell(_ cell: ProductCell, at indexPath: IndexPath)
    func selectProduct(at indexPath: IndexPath)
    func handleTextInput(_ text: String)
    func filterTapped()
    func addProductTapped()
    func deinitEvent()
}
