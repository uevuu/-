//
//  HomePresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit

// MARK: - HomePresenter
final class HomePresenter {
    weak var view: HomeViewInput?
    private weak var output: HomePresenterOutput?
    private let productsService: ProductsService
    private let productLocalDataSources: ProductLocalDataSources
    private var products: [Product] = []
    
    init(
        output: HomePresenterOutput?,
        productsService: ProductsService,
        productLocalDataSources: ProductLocalDataSources
    ) {
        self.output = output
        self.productsService = productsService
        self.productLocalDataSources = productLocalDataSources
    }
    
    deinit {
        print("deinit Home presenter")
    }
}

// MARK: - HomeViewOutput
extension HomePresenter: HomeViewOutput {
    func viewDidLoadEvent() {
        productsService.getProducts { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                DispatchQueue.main.async {
                    self?.view?.reloadView()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func getProductsCount() -> Int {
        return products.count
    }
    
    func configureCell(
        _ cell: ProductCell,
        at indexPath: IndexPath
    ) {
        let product = products[indexPath.item]
        cell.configureCell(
            imageUrl: product.image,
            price: product.price,
            title: product.title,
            sellerName: product.sellerName
        )
    }
    
    func selectProduct(at indexPath: IndexPath) {
        productLocalDataSources.setSelectedProduct(products[indexPath.item])
        output?.goToProductModule()
    }
    
    func handleTextInput(_ text: String) {
        print("search some")
    }
    
    func filterTapped() {
        output?.goToFilterModule()
    }
    
    func addProductTapped() {
        output?.goToCreateProductModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
