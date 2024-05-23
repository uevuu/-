//
//  ProductInfoCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.07.2023.
//

import UIKit
import Swinject

// MARK: - ProductInfoCoordinator
final class ProductInfoCoordinator: FlowCoordinatorProtocol {
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
        print("deinit Prodcut Info Coordinator")
    }
    
    func start(animated: Bool) {
        let productInfoBuilder = ProductInfoBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = productInfoBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - ProductInfoPresenterOutput
extension ProductInfoCoordinator: ProductInfoPresenterOutput {
    func goToHomeModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
