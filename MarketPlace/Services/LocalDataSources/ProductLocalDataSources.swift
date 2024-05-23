//
//  ProductLocalDataSources.swift
//  MarketPlace
//
//  Created by Nikita Marin on 14.10.2023.
//

final class ProductLocalDataSources {
    private var selectedProduct: Product?
    private var selectedProductInCartInfo: ProductInCartInfo?
    
    func getSelectedProduct() -> Product {
        guard let product = selectedProduct else {
            fatalError("You forgot to specify the product")
        }
        return product
    }
    
    func setSelectedProduct(_ product: Product) {
        selectedProduct = product
    }
    
    func setSelectedProductInCartInfo(_ productInfo: ProductInCartInfo) {
        selectedProductInCartInfo = productInfo
    }
    
    func getSelectedProductInCartInfo() -> ProductInCartInfo {
        guard let productInfo = selectedProductInCartInfo else {
            fatalError("You forgot to specify the product in cart info")
        }
        return productInfo
    }
}
