//
//  ProfilePresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

// MARK: - ProfilePresenterOutput
protocol ProfilePresenterOutput: AnyObject {
    func goToUserInfoModule()
    func goToCashInModule()
    func goToMyOrderModule()
    func goToChooseCityModule()
    func goToAppColorTheme()
}
