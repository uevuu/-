//
//  CartPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import Foundation
import Combine

// MARK: - CartPresenter
final class CartPresenter {
    weak var view: CartViewInput?
    private weak var output: CartPresenterOutput?
    private let cartService: CartService
    private let productLocalDataSources: ProductLocalDataSources
    private var productsInCart: [ProductInCartInfo] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        output: CartPresenterOutput?,
        cartService: CartService,
        productLocalDataSources: ProductLocalDataSources
    ) {
        self.output = output
        self.cartService = cartService
        self.productLocalDataSources = productLocalDataSources
    }
    
    deinit {
        print("deinit Cart presenter")
    }
}

// MARK: - CartViewOutput
extension CartPresenter: CartViewOutput {
    func viewDidLoadEvent() {
        cartService.currentProductsPublisher
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] products in
                guard let self else { return }
                self.productsInCart = products
                DispatchQueue.main.async {
                    self.view?.reloadCart()
                }
            }
            .store(in: &cancellables)
    }
    
    func getItemsInCartCount() -> Int {
        return productsInCart.count
    }
    
    func configureCell(
        _ cell: ProductInCartTableViewCell,
        at indexPath: IndexPath
    ) {
        let product = productsInCart[indexPath.item].product
        let productInfo = productsInCart[indexPath.item]
        cell.setSelected(productInfo.addedToOrder, animated: true)
        cell.configureCell(
            title: product.title,
            sellerName: product.sellerName,
            count: "\(productInfo.count) шт.",
            price: "\(product.price) б.",
            addedToOrder: productInfo.addedToOrder,
            imageUrlString: product.image
        )
    }
    
    func deleteSelected() {
        cartService.removeFromCar(products: productsInCart)
    }
    
    func selectAll() {
        cartService.addAllToOrder()
    }
    
    func selectProduct(at index: Int) {
        let product = productsInCart[index]
        product.addedToOrder ? cartService.removeFromOrder(product: product) : cartService.addToOrder(product: product)
    }
    
    func deleteProduct(at index: Int) {
        cartService.removeFromCar(product: productsInCart[index].product)
    }
    
    func selectCount(at index: Int) {
        productLocalDataSources.setSelectedProductInCartInfo(productsInCart[index])
        output?.goToSelectProductCountModule()
    }
    
    func proceedToCheckout() {
        output?.goToSelectAddressModule()
    }
    
    func selectProduct(at indexPath: IndexPath) {
        productLocalDataSources.setSelectedProduct(productsInCart[indexPath.item].product)
        output?.goToProductModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
