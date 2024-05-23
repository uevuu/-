//
//  UserTabBarCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - UserTabBarCoordinator
final class UserTabBarCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private let window: UIWindow
    private let tabBarController: UITabBarController = {
        var tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = R.color.background()
        tabBar.tabBar.tintColor = R.color.blue()
        return tabBar
    }()
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    private var finishHandlers: [(() -> Void)] = []
    
    init(
        window: UIWindow,
        resolver: Resolver,
        finishHandler: @escaping (() -> Void)
    ) {
        self.window = window
        self.resolver = resolver
        finishHandlers.append(finishHandler)
    }
    
    deinit {
        print("deinit user tab bar coordinator")
    }
    
    func start(animated: Bool) {
        window.rootViewController = tabBarController
        let homeCoordinator = HomeCoordinator(
            resolver: resolver,
            tabBar: tabBarController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: HomeCoordinator.self)
        }
        let cartCoordinator = CartCoordinator(
            resolver: resolver,
            tabBar: tabBarController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: CartCoordinator.self)
        }
        let profileCoordinator = ProfileCoordinator(
            resolver: resolver,
            tabBar: tabBarController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: ProfileCoordinator.self)
        }
        profileCoordinator.delegate = self
        homeCoordinator.start(animated: false)
        cartCoordinator.start(animated: false)
        profileCoordinator.start(animated: false)
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(cartCoordinator)
        childCoordinators.append(profileCoordinator)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
    }
}

extension UserTabBarCoordinator: FinishCoordinatorDelegate {
    func close() {
        finishHandlers.forEach { $0() }
    }
}
