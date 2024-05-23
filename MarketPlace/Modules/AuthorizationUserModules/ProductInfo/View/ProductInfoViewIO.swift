//
//  ProductInfoViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.07.2023.
//

import Foundation

// MARK: - ProductInfoViewInput
protocol ProductInfoViewInput: AnyObject {
    func makeCartButtonPressed()
    func makeCartButtonNotPressed()
}

// MARK: - ProductInfoViewOutput
protocol ProductInfoViewOutput: AnyObject {
    func viewDidLoadEvent()
    func configureCell(_ cell: ProductImageCell, at indexPath: IndexPath)
    func configureFooter(_ footer: ProductInfoView, at indexPath: IndexPath)
    func getImagesCount() -> Int
    func addToCartTapped()
    func backTapped()
    func deinitEvent()
}
