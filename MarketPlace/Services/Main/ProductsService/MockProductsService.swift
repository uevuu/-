//
//  MockProductsService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 13.10.2023.
//

// MARK: - MockProductsService
final class MockProductsService: ProductsService {
    // swiftlint:disable all
    private var products = [
        Product(
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
        Product(
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
        Product(
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
        Product(
            id: 4,
            title: "Костюм спортивный",
            sellerName: "Русич спорт",
            price: 6599,
            categoryId: 4,
            quantity: 10,
            description: "Мужской утеплённый спортивный костюм «СССР» изготовлен в темно-синем цвете.",
            image: "https://ir.ozone.ru/s3/multimedia-j/wc750/6796130491.jpg", 
            moreImages: [
                "https://ir.ozone.ru/s3/multimedia-k/wc750/6796130492.jpg",
                "https://ir.ozone.ru/s3/multimedia-g/wc750/6796130524.jpg",
                "https://ir.ozone.ru/s3/multimedia-j/wc750/6796130527.jpg",
                "https://ir.ozone.ru/s3/multimedia-n/wc750/6796130495.jpg"
            ]
        ),
        Product(
            id: 5,
            title: "Костюм Terrex Climacool",
            sellerName: "Adidas",
            price: 4999,
            categoryId: 4,
            quantity: 8,
            description: "В этом спортивном костюме adidas можно пойти куда угодно и заниматься чем угодно.",
            image: "https://ir.ozone.ru/s3/multimedia-2/wc750/6782116178.jpg",
            moreImages: [
                "https://ir.ozone.ru/s3/multimedia-d/wc750/6782116189.jpg",
                "https://ir.ozone.ru/s3/multimedia-4/wc750/6782116180.jpg",
                "https://ir.ozone.ru/s3/multimedia-1/wc750/6782116177.jpg",
                "https://ir.ozone.ru/s3/multimedia-3/wc750/6782116179.jpg",
                "https://ir.ozone.ru/s3/multimedia-6/wc750/6782116182.jpg"
            ]
        )

    ]
    // swiftlint:enable all
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        completion(.success(products))
    }
    
    func getSellerProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        completion(.success(products))
    }
    
    func getProductDetailInfo(
        productId: Int,
        completion: @escaping (Result<Product, Error>) -> Void
    ) {
        if let product = products.first(where: { $0.id == productId }) {
            completion(.success(product))
        }
    }
}
