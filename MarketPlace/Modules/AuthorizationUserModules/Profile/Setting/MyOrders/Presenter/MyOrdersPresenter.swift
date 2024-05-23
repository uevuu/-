//
//  MyOrdersPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - MyOrdersPresenter
final class MyOrdersPresenter {
    weak var view: MyOrdersViewInput?
    private var output: MyOrdersPresenterOutput?
    
    init(output: MyOrdersPresenterOutput?) {
        self.output = output
    }
    
    deinit {
        print("deinit My Order Presenter")
    }
}

// MARK: - MyOrdersViewOutput
extension MyOrdersPresenter: MyOrdersViewOutput {
    func getOrdersCount() -> Int {
        return 4
    }
    
    func configureCell(
        _ cell: OrderTableViewCell,
        at indexPath: IndexPath
    ) {
        cell.configureCell(
            dataInfo: "15 марта",
            priceInfo: "5 000",
            imageUrls: ["productImage", "productImage"]
        )
    }
    
    func selectOrder(at indexPath: IndexPath) {
        output?.goToOrderInfoModule()
    }
    
    func backTapped() {
        output?.goToProfileModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
