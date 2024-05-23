//
//  EditProductPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import Foundation

// MARK: - EditProductPresenter
final class EditProductPresenter {
    weak var view: EditProductViewInput?
    private weak var output: EditProductPresenterOutput?
    
    init(output: EditProductPresenterOutput?) {
        self.output = output
    }
    
    deinit {
        print("deinit Edit Product Info presenter")
    }
}

// MARK: - EditProductViewOutput
extension EditProductPresenter: EditProductViewOutput {
    func configureCell(
        _ cell: ProductImageCell,
        at indexPath: IndexPath
    ) {
        cell.configureCell(imageUrl: "productImage")
    }
    
    func configureFooter(
        _ footer: EditProductInfoFooter,
        at indexPath: IndexPath
    ) {
        footer.configureCell(
            title: "Платье женское черное",
            sellerName: "Anna S",
            price: "3 500 б.",
            description: R.string.localizable.mockDescription()
        )
    }
    
    func getImagesCount() -> Int {
        return 4
    }
    
    func editTapped() {
        output?.goToEditModule()
    }
    
    func countTapped() {
        output?.goToSetProductCountModule()
    }
    
    func deleteTapped() {
        print("delete")
    }
    
    func backTapped() {
        output?.goToHomeModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
