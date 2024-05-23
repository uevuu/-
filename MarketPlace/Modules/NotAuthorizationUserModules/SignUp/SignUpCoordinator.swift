//
//  SignUpCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - SignUpCoordinator
final class SignUpCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    weak var delegate: WelcomeCoordinatorFinishDelegate?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController?
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit signUp Coordintor")
    }
    
    func start(animated: Bool) {
        let builder = SignUpBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = builder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
    }
}

// MARK: - SignUpPresenterOutput
extension SignUpCoordinator: SignUpPresenterOutput {
    func goToPreviousModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToUserModule() {
        delegate?.welcomeCoordinatorDidFinish()
    }
}
