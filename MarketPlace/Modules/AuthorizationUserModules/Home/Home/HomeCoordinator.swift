//
//  HomeCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - HomeCoordinator
final class HomeCoordinator: FlowCoordinatorProtocol {
    private let isSeller: Bool
    private let resolver: Resolver
    private weak var parentTabBar: UITabBarController?
    private var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(
        isSeller: Bool = false,
        resolver: Resolver,
        tabBar: UITabBarController,
        finishHandler: @escaping (() -> Void)
    ) {
        self.isSeller = isSeller
        self.resolver = resolver
        self.parentTabBar = tabBar
        finishHandlers.append(finishHandler)
    }
    
    deinit {
        print("deinit Home Coordinator")
    }
    
    func start(animated: Bool) {
        let homeBuilder = HomeBuilder(
            isSeller: isSeller,
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = homeBuilder.build()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        parentTabBar?.addViewController(
            viewController: navigationController,
            image: UIImage(systemName: "house")
        )
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
        navigationController?.viewControllers = []
    }
}

// MARK: - HomePresenterOutput
extension HomeCoordinator: HomePresenterOutput {
    func goToProductModule() {
        if isSeller {
            let editProductCoordinator = EditProductCoordinator(
                resolver: resolver,
                navigationController: navigationController
            ) { [weak self] in
                self?.childCoordinators.removeFlowCoordinator(ofType: EditProductCoordinator.self)
            }
            childCoordinators.append(editProductCoordinator)
            editProductCoordinator.start(animated: true)
        } else {
            let productInfoCoordinator = ProductInfoCoordinator(
                resolver: resolver,
                navigationController: navigationController
            ) { [weak self] in
                self?.childCoordinators.removeFlowCoordinator(ofType: ProductInfoCoordinator.self)
            }
            childCoordinators.append(productInfoCoordinator)
            productInfoCoordinator.start(animated: true)
        }
    }
    
    func goToFilterModule() {
        let filterCoordinator = FilterCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: FilterCoordinator.self)
        }
        childCoordinators.append(filterCoordinator)
        filterCoordinator.start(animated: true)
    }
    
    func goToCreateProductModule() {
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
