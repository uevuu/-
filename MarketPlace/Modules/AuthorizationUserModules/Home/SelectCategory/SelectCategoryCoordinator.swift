//
//  SelectCategoryCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectCategoryCoordinator
final class SelectCategoryCoordinator: FlowCoordinatorProtocol {
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
        print("deinit Select Category Coordinator")
    }
    
    func start(animated: Bool) {
        let selectCategoryBuilder = SelectCategoryBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = selectCategoryBuilder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
        navigationController?.popViewController(animated: animated)
    }
}

// MARK: - SelectCategoryPresenterOutput
extension SelectCategoryCoordinator: SelectCategoryPresenterOutput {
    func goToPreviousModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToHomeModule() {
        print("close all module before home")
    }
    
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
}
