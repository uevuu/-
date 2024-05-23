//
//  MockCartService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 13.10.2023.
//

import Combine

// MARK: - MockCartService
final class MockCartService: CartService {
    // swiftlint:disable all
    
    init() {
        self.currentProductsPublisher = CurrentValueSubject<[ProductInCartInfo], Never>(productsInCar)
    }
    
    var currentProductsPublisher: CurrentValueSubject<[ProductInCartInfo], Never>
    
    private var productsInCar = [
        ProductInCartInfo(
            product: Product(
                id: 1,
                title: "Футболка",
                sellerName: "ТВОЕ",
                price: 999,
                categoryId: 1,
                quantity: 34,
                description: "Модель изготовлена из хлопка, поэтому легко очищается от загрязнений, хорошо держит форму и отличается высокой прочностью.",
                image: "https://ir.ozone.ru/s3/multimedia-d/wc750/6707461189.jpg",
                moreImages: []
            ),
            count: 1,
            addedToOrder: false
        ),
        ProductInCartInfo(
            product: Product(
                id: 2,
                title: "Штаны",
                sellerName: "ТВОЕ",
                price: 1699,
                categoryId: 2,
                quantity: 71,
                description: "Штаны давно стали важным элементом гардероба практически каждого мужчины. Они практичны и комфортны.",
                image: "https://ir.ozone.ru/s3/multimedia-x/wc750/6614303217.jpg",
                moreImages: []
            ),
            count: 2,
            addedToOrder: true
        ),
        ProductInCartInfo(
            product: Product(
                id: 3,
                title: "Худи",
                sellerName: "ARISTARHOV",
                price: 2199,
                categoryId: 3,
                quantity: 28,
                description: "Оригинальная толстовка с капюшоном из плотного материала и удобна в повседневной носке.",
                image: "https://ir.ozone.ru/s3/multimedia-u/wc750/6718746738.jpg",
                moreImages: [
                    "https://ir.ozone.ru/s3/multimedia-y/wc750/6718746850.jpg",
                    "https://ir.ozone.ru/s3/multimedia-9/wc750/6718746861.jpg",
                    "https://ir.ozone.ru/s3/multimedia-8/wc750/6718746824.jpg"
                ]
            ),
            count: 1,
            addedToOrder: false
        )
    ]
    // swiftlint:enable all
    
    func loadProducts(completion: @escaping (Result<[ProductInCartInfo], Error>) -> Void) {
        completion(.success(productsInCar))
    }
    func getProducts() -> [ProductInCartInfo]? {
        return productsInCar
    }
    
    func productInCar(productId: Int) -> Bool {
        return productsInCar.contains { $0.product.id == productId }
    }
    
    func addToCar(product: Product) {
        if !productsInCar.contains(where: { $0.product.id == product.id }) {
            productsInCar.append(
                ProductInCartInfo(
                    product: product,
                    count: 1,
                    addedToOrder: false
                )
            )
            currentProductsPublisher.send(productsInCar)
        }
    }
    
    func removeFromCar(product: Product) {
        productsInCar.removeAll { $0.product.id == product.id }
        currentProductsPublisher.send(productsInCar)
    }
    
    func removeFromCar(products: [ProductInCartInfo]) {
        products.forEach { product in
            productsInCar.removeAll { $0.product.id == product.product.id && $0.addedToOrder }
        }
        currentProductsPublisher.send(productsInCar)
    }
    
    func updateCount(
        count: Int,
        product: ProductInCartInfo
    ) {
        if let index = productsInCar.firstIndex(where: { $0.product.id == product.product.id }) {
            productsInCar[index] = ProductInCartInfo(
                product: product.product,
                count: count,
                addedToOrder: product.addedToOrder
            )
            currentProductsPublisher.send(productsInCar)
        }
    }
    
    func addToOrder(product: ProductInCartInfo) {
        setAddedStatus(product: product, added: true)
        currentProductsPublisher.send(productsInCar)
    }
    
    func addAllToOrder() {
        productsInCar.forEach { product in
            setAddedStatus(product: product, added: true)
        }
        currentProductsPublisher.send(productsInCar)
    }
    
    func removeFromOrder(product: ProductInCartInfo) {
        setAddedStatus(product: product, added: false)
        currentProductsPublisher.send(productsInCar)
    }
    
    private func setAddedStatus(product: ProductInCartInfo, added: Bool) {
        if let index = productsInCar.firstIndex(where: { $0.product.id == product.product.id }) {
            productsInCar[index] = ProductInCartInfo(
                product: product.product,
                count: product.count,
                addedToOrder: added
            )
        }
    }
}
