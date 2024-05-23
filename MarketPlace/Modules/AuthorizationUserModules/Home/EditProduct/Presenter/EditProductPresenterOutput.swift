//
//  EditProductPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

// MARK: - EditProductPresenterOutput
protocol EditProductPresenterOutput: AnyObject {
    func goToHomeModule()
    func goToSetProductCountModule()
    func goToEditModule()
    func moduleDidUnload()
}
