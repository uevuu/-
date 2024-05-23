//
//  WelcomeCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - WelcomeCoordinator
final class WelcomeCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private let window: UIWindow
    private weak var navigationController: UINavigationController?
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(
        resolver: Resolver,
        window: UIWindow,
        finishHandler: @escaping (() -> Void)
    ) {
        self.resolver = resolver
        self.window = window
        finishHandlers.append(finishHandler)
    } 
    
    deinit {
        print("deinit welcome coordinator")
    }
    
    func start(animated: Bool) {
        let builder = WelcomeBuilder(moduleOutput: self)
        let viewController = builder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.addBottomLine(with: R.color.placeholderBottomLine())
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
    }
}

// MARK: - WelcomePresenterOutput
extension WelcomeCoordinator: WelcomePresenterOutput {
    func goToLogInModule() {
        let logInCoordinator = LogInCoordinator(
            resolver: resolver,
            navigationController: navigationController
        )
        logInCoordinator.delegate = self
        logInCoordinator.start(animated: true)
    }
    
    func goToSignUpModule() {
        let signUpCoordinator = SignUpCoordinator(
            resolver: resolver,
            navigationController: navigationController
        )
        signUpCoordinator.delegate = self
        signUpCoordinator.start(animated: true)
    }
}

extension WelcomeCoordinator: WelcomeCoordinatorFinishDelegate {
    func welcomeCoordinatorDidFinish() {
        finishHandlers.forEach { $0() }
    }
}
