//
//  LogInViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import Foundation

// MARK: - LogInViewInput
protocol LogInViewInput: AnyObject {
    func showPhoneNumberOrEmailValidationError()
    func showEmptyEmailOrPhoneError()
    func showEmptyPasswordError()
    func showUserExistError()
    func hideUserExistError()
    func showPasswordError()
    func hidePasswordError()
}

// MARK: - LogInViewOutput
protocol LogInViewOutput: AnyObject {
    func backTapped()
    func logInTapped(
        emailOrPhone: String,
        password: String
    )
}
