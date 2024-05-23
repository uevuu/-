//
//  RootCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - RootCoordinator
final class RootCoordinator {
    private let window: UIWindow
    private let resolver: Resolver
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var isAuth = true
    
    init(window: UIWindow, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
    }
    
    deinit {
        print("deinit")
    }
    
    func start() {
        let sellerTabBarCoordinator = UserTabBarCoordinator(
            window: window,
            resolver: resolver
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: UserTabBarCoordinator.self)
            self?.showWelcomeFlow()
        }
        sellerTabBarCoordinator.start(animated: false)
        childCoordinators.append(sellerTabBarCoordinator)
        window.makeKeyAndVisible()
    }
    
    private func showWelcomeFlow() {
        let welcomeCoordinator = WelcomeCoordinator(
            resolver: resolver,
            window: window
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: WelcomeCoordinator.self)
            self?.showUserFlow()
        }
        welcomeCoordinator.start(animated: false)
        childCoordinators.append(welcomeCoordinator)
    }
    
    private func showUserFlow() {
        if let status = UserDefaults.standard.string(forKey: "roles") {
            if status == "SELLER" {
                let sellerTabBarCoordinator = SellerTabBarCoordinator(
                    window: window,
                    resolver: resolver
                ) { [weak self] in
                    self?.childCoordinators.removeFlowCoordinator(ofType: SellerTabBarCoordinator.self)
                    self?.showWelcomeFlow()
                }
                sellerTabBarCoordinator.start(animated: false)
                childCoordinators.append(sellerTabBarCoordinator)
            } else {
                let userTabBarCoordinator = UserTabBarCoordinator(
                    window: window,
                    resolver: resolver
                ) { [weak self] in
                    self?.childCoordinators.removeFlowCoordinator(ofType: UserTabBarCoordinator.self)
                    self?.showWelcomeFlow()
                }
                userTabBarCoordinator.start(animated: false)
                childCoordinators.append(userTabBarCoordinator)
            }
        } else {
            showWelcomeFlow()
        }
    }
//
//    private func showUserFlow() {
//        let userTabBarCoordinator = UserTabBarCoordinator(
//            window: window,
//            resolver: resolver
//        ) { [weak self] in
//            self?.childCoordinators.removeFlowCoordinator(ofType: UserTabBarCoordinator.self)
//            self?.showWelcomeFlow()
//        }
//        userTabBarCoordinator.start(animated: false)
//        childCoordinators.append(userTabBarCoordinator)
//    }
//
//    private func showSellerFlow() {
//        let sellerTabBarCoordinator = SellerTabBarCoordinator(
//            window: window,
//            resolver: resolver
//        ) { [weak self] in
//            self?.childCoordinators.removeFlowCoordinator(ofType: SellerTabBarCoordinator.self)
//            self?.showWelcomeFlow()
//        }
//        sellerTabBarCoordinator.start(animated: false)
//        childCoordinators.append(sellerTabBarCoordinator)
//    }
}
