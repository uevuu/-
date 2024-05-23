//
//  ProductInfoPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.07.2023.
//

import Foundation
import Combine

// MARK: - ProductInfoPresenter
final class ProductInfoPresenter {
    weak var view: ProductInfoViewInput?
    private weak var output: ProductInfoPresenterOutput?
    private let cartService: CartService
    private let selectedProduct: Product
    private var productInCar = false
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        output: ProductInfoPresenterOutput?,
        cartService: CartService,
        productLocalDataSources: ProductLocalDataSources
    ) {
        self.output = output
        self.cartService = cartService
        self.selectedProduct = productLocalDataSources.getSelectedProduct()
    }
    
    deinit {
        print("deinit Product Info presenter")
    }
}

// MARK: - ProductInfoViewOutput
extension ProductInfoPresenter: ProductInfoViewOutput {    
    func viewDidLoadEvent() {
        cartService.currentProductsPublisher
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] productsInCar in
                guard let self else { return }
                if productsInCar.contains(where: { $0.product.id == self.selectedProduct.id }) {
                    DispatchQueue.main.async {
                        self.view?.makeCartButtonPressed()
                    }
                    self.productInCar = true
                } else {
                    DispatchQueue.main.async {
                        self.view?.makeCartButtonNotPressed()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func getImagesCount() -> Int {
        return selectedProduct.moreImages.count + 1
    }
    
    func configureCell(
        _ cell: ProductImageCell,
        at indexPath: IndexPath
    ) {
        if indexPath.item == 0 {
            cell.configureCell(imageUrl: selectedProduct.image)
        } else {
            cell.configureCell(imageUrl: selectedProduct.moreImages[indexPath.item - 1])
        }
    }
    
    func configureFooter(
        _ footer: ProductInfoView,
        at indexPath: IndexPath
    ) {
        footer.configureCell(
            title: selectedProduct.title,
            sellerName: selectedProduct.sellerName,
            price: "\(selectedProduct.price) б.",
            description: selectedProduct.description
        )
    }
    
    func addToCartTapped() {
        productInCar ? 
        cartService.removeFromCar(product: selectedProduct) :
        cartService.addToCar(product: selectedProduct)
        productInCar.toggle()
    }
    
    func backTapped() {
        output?.goToHomeModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
