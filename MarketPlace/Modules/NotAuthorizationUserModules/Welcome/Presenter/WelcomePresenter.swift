//
//  WelcomePresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

// MARK: - WelcomePresenter
final class WelcomePresenter {
    weak var view: WelcomeViewInput?
    private var output: WelcomePresenterOutput?
    
    init(output: WelcomePresenterOutput?) {
        self.output = output
    }
    
    deinit {
        print("deinit welcome presenter")
    }
}

// MARK: - WelcomeViewOutput
extension WelcomePresenter: WelcomeViewOutput {
    func logInTapped() {
        output?.goToLogInModule()
    }
    
    func signUpTapped() {
        output?.goToSignUpModule()
    }
}
