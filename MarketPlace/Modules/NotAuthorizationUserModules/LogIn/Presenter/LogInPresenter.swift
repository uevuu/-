//
//  LogInPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

// MARK: - LogInPresenter
final class LogInPresenter {
    weak var view: LogInViewInput?
    private var output: LogInPresenterOutput?
    private let logInService: LogInService
    
    init(
        output: LogInPresenterOutput?,
        logInService: LogInService
    ) {
        self.output = output
        self.logInService = logInService
    }
    
    deinit {
        print("deinit login presenter")
    }
}

// MARK: - LogInViewOutput
extension LogInPresenter: LogInViewOutput {
    func backTapped() {
        output?.goToPreviousModule()
    }
    
    func logInTapped(
        emailOrPhone: String,
        password: String
    ) {
        if !emailOrPhone.isEmpty && !password.isEmpty {
            if emailOrPhone.isValidEmailOrPhoneNumber() {
                logInService.login(
                    emailOrPhoneNumber: emailOrPhone,
                    password: password
                ) { [weak view, output] result in
                    switch result {
                    case .userExist:
                        view?.showUserExistError()
                        view?.showPasswordError()
                    case .incorrectPassword:
                        view?.hideUserExistError()
                        view?.showPasswordError()
                    case .success:
                        view?.hideUserExistError()
                        view?.hidePasswordError()
                        output?.goToUserModule()
                    case .serviceError:
                        print("service error")
                    }
                }
            } else {
                view?.showPhoneNumberOrEmailValidationError()
                view?.showPasswordError()
            }
        } else {
            if emailOrPhone.isEmpty {
                view?.showEmptyEmailOrPhoneError()
            } else {
                if emailOrPhone.isValidEmailOrPhoneNumber() {
                    view?.hideUserExistError()
                } else {
                    view?.showPhoneNumberOrEmailValidationError()
                }
            }
            if password.isEmpty {
                view?.showEmptyPasswordError()
            }
        }
    }
}
