//
//  OrderInfoPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

// MARK: - OrderInfoPresenterOutput
protocol OrderInfoPresenterOutput: AnyObject {
    func moduleDidUnload()
    func goToMyOrderModule()
}
