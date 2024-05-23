//
//  EditProductCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit
import Swinject

// MARK: - EditProductCoordinator
final class EditProductCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    private var childCoordinators: [FlowCoordinatorProtocol] = []

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
        print("deinit Edit Product Coordinator")
    }
    
    func start(animated: Bool) {
        let editProductBuilder = EditProductBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = editProductBuilder.build()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
        navigationController?.viewControllers = []
    }
}

// MARK: - EditProductPresenterOutput
extension EditProductCoordinator: EditProductPresenterOutput {
    func goToHomeModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToSetProductCountModule() {
        print("next")
    }
    
    func goToEditModule() {
        let createProductCoordinator = CreateProductCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: CreateProductCoordinator.self)
        }
        childCoordinators.append(createProductCoordinator)
        createProductCoordinator.start(animated: true)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
