//
//  UserInfoPresenterOutput.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

// MARK: - UserInfoPresenterOutput
protocol UserInfoPresenterOutput: AnyObject {
    func goToUserInfoModule()
    func goToWelcomeModule()
    func moduleDidUnload()
}
