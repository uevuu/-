//
//  SignUpViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

// MARK: - SignUpViewInput
protocol SignUpViewInput: AnyObject {
    func showEmailValidationError()
    func hideEmailValidationError()
    func showPhoneNumberValidationError()
    func showPasswordValidationError()
    func showEmptyFirstNameError()
    func showEmptyLastNameError()
    func showEmptyEmailError()
    func showEmptyPhoneNumberError()
    func showEmptyPasswordError()
    func showSameEmailError()
    func showSamePhoneNumberError()
    func hidePhoneNumberValidationError()
    func hidePasswordValidationError()
}

// MARK: - SignUpViewOutput
protocol SignUpViewOutput: AnyObject {
    func backTapped()
    func signUpTapped(signUpData: SignUpData)
}

struct SignUpData {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let password: String
    let isSeller: Bool
    
    func isValid() -> Bool {
        return email.isValidEmail()
        && phoneNumber.isValidPhoneNumber()
        && password.isValidPassword()
        && !firstName.isEmpty
        && !lastName.isEmpty
    }
}
