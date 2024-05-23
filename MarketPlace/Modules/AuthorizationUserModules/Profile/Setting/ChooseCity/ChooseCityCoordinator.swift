//
//  ChooseCityCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit
import Swinject

// MARK: - ChooseCityCoordinator
final class ChooseCityCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController?
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit Choose City Coordinator")
    }
    
    func start(animated: Bool) {
        let chooseCityBuilder = ChooseCityBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = chooseCityBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
    }
}

// MARK: - ChooseCityPresenterOutput
extension ChooseCityCoordinator: ChooseCityPresenterOutput {
    func goToProfileModule() {
        navigationController?.popViewController(animated: true)
    }
}
