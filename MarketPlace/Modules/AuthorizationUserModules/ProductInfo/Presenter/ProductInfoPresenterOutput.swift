//
//  ProductInfoPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.07.2023.
//

// MARK: - ProductInfoPresenterOutput
protocol ProductInfoPresenterOutput: AnyObject {
    func moduleDidUnload()
    func goToHomeModule()
}
