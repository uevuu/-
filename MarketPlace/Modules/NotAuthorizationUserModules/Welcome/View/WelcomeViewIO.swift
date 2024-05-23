//
//  WelcomeViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import Foundation

// MARK: - WelcomeViewInput
protocol WelcomeViewInput: AnyObject {
}

// MARK: - WelcomeViewOutput
protocol WelcomeViewOutput: AnyObject {
    func logInTapped()
    func signUpTapped()
}
