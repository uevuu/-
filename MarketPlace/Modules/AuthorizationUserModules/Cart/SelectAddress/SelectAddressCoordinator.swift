//
//  SelectAddressCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectAddressCoordinator
final class SelectAddressCoordinator: FlowCoordinatorProtocol {
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
        print("deinit Select address  Coordinator")
    }
    
    func start(animated: Bool) {
        let selectAddressBuilder = SelectAddressBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = selectAddressBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
    }
}

// MARK: - SelectAddressPresenterOutput
extension SelectAddressCoordinator: SelectAddressPresenterOutput {
    func goToCartModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goNextModule() {
        print("in future")
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
