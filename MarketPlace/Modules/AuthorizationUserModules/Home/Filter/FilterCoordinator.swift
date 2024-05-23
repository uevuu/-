//
//  FilterCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit
import Swinject

// MARK: - FilterCoordinator
final class FilterCoordinator: FlowCoordinatorProtocol {
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
        print("deinit Filter Coordinator")
    }
    
    func start(animated: Bool) {
        let filterBuilder = FilterBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = filterBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - FilterPresenterOutput
extension FilterCoordinator: FilterPresenterOutput {
    func goToHomeModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
