//
//  MyOrdersPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

// MARK: - MyOrdersPresenterOutput
protocol MyOrdersPresenterOutput: AnyObject {
    func goToProfileModule()
    func goToOrderInfoModule()
    func moduleDidUnload()
}
