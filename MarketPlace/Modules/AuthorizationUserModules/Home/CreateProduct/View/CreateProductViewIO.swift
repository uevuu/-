//
//  CreateProductViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import Foundation

// MARK: - CreateProductViewInput
protocol CreateProductViewInput: AnyObject {
}

// MARK: - CreateProductViewOutput
protocol CreateProductViewOutput: AnyObject {
    func configureCell(_ cell: DeleteProductImageCell, at indexPath: IndexPath)
    func getImagesCount() -> Int
    func deletePhoto(at index: Int)
    func nextTapped()
    func backTapped()
    func deinitEvent()
}
