//
//  ProfileCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - ProfileCoordinator
final class ProfileCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var tabBar: UITabBarController?
    private var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    weak var delegate: FinishCoordinatorDelegate?
    
    init(
        resolver: Resolver,
        tabBar: UITabBarController,
        finishHandler: @escaping (() -> Void)
    ) {
        self.resolver = resolver
        self.tabBar = tabBar
        finishHandlers.append(finishHandler)
    }
    
    deinit {
        print("deinit Profile Coordinator")
    }
    
    func start(animated: Bool) {
        let profileBuilder = ProfileBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = profileBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.addBottomLine(with: R.color.placeholderBottomLine())
        self.navigationController = navigationController
        tabBar?.addViewController(
            viewController: navigationController,
            image: UIImage(systemName: "person.crop.circle")
        )
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
        navigationController?.viewControllers = []
    }
}

// MARK: - ProfilePresenterOutput
extension ProfileCoordinator: ProfilePresenterOutput {
    func goToUserInfoModule() {
        let userInfoCoordinator = UserInfoCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: UserInfoCoordinator.self)
        }
        userInfoCoordinator.delegate = self
        childCoordinators.append(userInfoCoordinator)
        userInfoCoordinator.start(animated: true)
    }
    
    func goToCashInModule() {
        let cashInCoordinator = CashInCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: CashInCoordinator.self)
        }
        childCoordinators.append(cashInCoordinator)
        cashInCoordinator.start(animated: true)
    }
    
    func goToMyOrderModule() {
        let myOrdersCoordinator = MyOrdersCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: MyOrdersCoordinator.self)
        }
        childCoordinators.append(myOrdersCoordinator)
        myOrdersCoordinator.start(animated: true)
    }
    
    func goToChooseCityModule() {
        let chooseCityCoordinator = ChooseCityCoordinator(
            resolver: resolver,
            navigationController: navigationController
        )
        chooseCityCoordinator.start(animated: true)
    }
    
    func goToAppColorTheme() {
        print("build app color module")
    }
}

extension ProfileCoordinator: FinishCoordinatorDelegate {
    func close() {
        delegate?.close()
    }
}
