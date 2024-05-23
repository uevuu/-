//
//  OrderInfoPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import Foundation

import UIKit

// MARK: - OrderInfoPresenter
final class OrderInfoPresenter {
    weak var view: OrderInfoViewInput?
    private var output: OrderInfoPresenterOutput?
    
    init(output: OrderInfoPresenterOutput?) {
        self.output = output
    }
    
    deinit {
        print("deinit Order Info Presenter")
    }
}

// MARK: - OrderInfoViewOutput
extension OrderInfoPresenter: OrderInfoViewOutput {
    func getProductsCount() -> Int {
        return 3
    }
    
    func configureCell(
        _ cell: UserOrderInfoTableViewCell,
        at indexPath: IndexPath
    ) {
        cell.configureCell(
            title: "Кроссовки adidas",
            seller: "Q Shoop",
            count: "\(R.string.localizable.count()) 1 шт.",
            price: "1 900 б.",
            imageUrlString: "productImage"
        )
    }
    func configureHeader(_ header: OrderInfoPreViewHeader) {
        header.configureHeader(address: "г Казань, ул Чистопольская, д 13", price: "5 000 б.")
    }
    
    func backTapped() {
        output?.goToMyOrderModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
