//
//  CreateProductPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

// MARK: - CreateProductPresenterOutput
protocol CreateProductPresenterOutput: AnyObject {
    func goToHomeModule()
    func goToSelectCategoryModule()
    func moduleDidUnload()
}
