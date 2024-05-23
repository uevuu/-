//
//  SelectAddressPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

// MARK: - SelectAddressPresenterOutput
protocol SelectAddressPresenterOutput: AnyObject {
    func goToCartModule()
    func goNextModule()
    func moduleDidUnload()
}
