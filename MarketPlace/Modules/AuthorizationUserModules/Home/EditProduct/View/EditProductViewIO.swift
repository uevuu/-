//
//  EditProductViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import Foundation

// MARK: - EditProductViewInput
protocol EditProductViewInput: AnyObject {
}

// MARK: - EditProductViewOutput
protocol EditProductViewOutput: AnyObject {
    func configureCell(_ cell: ProductImageCell, at indexPath: IndexPath)
    func configureFooter(_ footer: EditProductInfoFooter, at indexPath: IndexPath)
    func getImagesCount() -> Int
    func editTapped()
    func countTapped()
    func deleteTapped()
    func backTapped()
    func deinitEvent()
}
