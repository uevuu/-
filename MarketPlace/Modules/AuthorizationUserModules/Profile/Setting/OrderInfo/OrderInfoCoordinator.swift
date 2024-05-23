//
//  OrderInfoCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit
import Swinject

// MARK: - OrderInfoCoordinator
final class OrderInfoCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    private var finishHandlers: [(() -> Void)] = []
    
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
        print("deinit Order Info Coordinator")
    }
    
    func start(animated: Bool) {
        let orderInfoBuilder = OrderInfoBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = orderInfoBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - OrderInfoPresenterOutput
extension OrderInfoCoordinator: OrderInfoPresenterOutput {
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
    
    func goToMyOrderModule() {
        navigationController?.popViewController(animated: true)
    }
}
