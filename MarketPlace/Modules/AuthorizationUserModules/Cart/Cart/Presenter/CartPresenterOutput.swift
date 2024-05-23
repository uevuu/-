//
//  CartPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

// MARK: - CartPresenterOutput
protocol CartPresenterOutput: AnyObject {
    func moduleDidUnload()
    func goToProductModule()
    func goToSelectAddressModule()
    func goToSelectProductCountModule()
}
