//
//  SelectCategoryPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

// MARK: - SelectCategoryPresenterOutput
protocol SelectCategoryPresenterOutput: AnyObject {
    func goToPreviousModule()
    func goToHomeModule()
    func moduleDidUnload()
}
