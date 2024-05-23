//
//  UserInfoCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit
import Swinject

protocol FinishCoordinatorDelegate: AnyObject {
    func close()
}

// MARK: - UserInfoCoordinator
final class UserInfoCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    weak var delegate: FinishCoordinatorDelegate?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController?,
        finishHandler: @escaping (() -> Void)
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
        finishHandlers.append(finishHandler)
    }
    
    deinit {
        print("deinit User Info Coordinator")
    }
    
    func start(animated: Bool) {
        let profileBuilder = UserInfoBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = profileBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - UserInfoCoordinator
extension UserInfoCoordinator: UserInfoPresenterOutput {
    func goToUserInfoModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToWelcomeModule() {
        delegate?.close()
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
