//
//  MyOrdersCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit
import Swinject

// MARK: - MyOrdersCoordinator
final class MyOrdersCoordinator: FlowCoordinatorProtocol {
    private let isSeller: Bool
    private let resolver: Resolver
    private weak var parentTabBar: UITabBarController?
    private weak var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    private var childCoordinators: [FlowCoordinatorProtocol] = []
    
    init(
        isSeller: Bool = false,
        resolver: Resolver,
        navigationController: UINavigationController? = nil,
        tabBar: UITabBarController? = nil,
        finishHandler: @escaping (() -> Void)
    ) {
        self.isSeller = isSeller
        self.resolver = resolver
        self.parentTabBar = tabBar
        self.navigationController = navigationController
        finishHandlers.append(finishHandler)
    }
    
    deinit {
        print("deinit My Orders Coordinator")
    }
    
    func start(animated: Bool) {
        let myOrdersBuilder = MyOrdersBuilder(
            isSeller: isSeller, 
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = myOrdersBuilder.build()
        guard let navigationController = navigationController else {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.addBottomLine(with: R.color.placeholderBottomLine())
            self.navigationController = navigationController
            parentTabBar?.addViewController(
                viewController: navigationController,
                image: UIImage(systemName: "archivebox")
            )
            return 
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        childCoordinators.finishAll(animated: animated, completion: nil)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - MyOrdersPresenterOutput
extension MyOrdersCoordinator: MyOrdersPresenterOutput {
    func goToProfileModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToOrderInfoModule() {
        let orderInfoCoordinator = OrderInfoCoordinator(
            resolver: resolver,
            navigationController: navigationController
        ) { [weak self] in
            self?.childCoordinators.removeFlowCoordinator(ofType: OrderInfoCoordinator.self)
        }
        childCoordinators.append(orderInfoCoordinator)
        orderInfoCoordinator.start(animated: true)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
