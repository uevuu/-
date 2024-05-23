//
//  CreateProductPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import Foundation

// MARK: - CreateProductPresenter
final class CreateProductPresenter {
    weak var view: CreateProductViewInput?
    private weak var output: CreateProductPresenterOutput?
    
    init(output: CreateProductPresenterOutput?) {
        self.output = output
    }
    
    deinit {
        print("deinit Create Product presenter")
    }
}

// MARK: - ProductInfoViewOutput
extension CreateProductPresenter: CreateProductViewOutput {
    func configureCell(_ cell: DeleteProductImageCell, at indexPath: IndexPath) {
        cell.configureCell(imageUrl: "productImage")
    }
    
    func getImagesCount() -> Int {
        return 9
    }
    
    func deletePhoto(at index: Int) {
        print("delete")
    }
    
    func nextTapped() {
        output?.goToSelectCategoryModule()
    }
    
    func backTapped() {
        output?.goToHomeModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
