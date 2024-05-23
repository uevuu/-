//
//  SelectProductCountCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectProductCountCoordinator
final class SelectProductCountCoordinator: FlowCoordinatorProtocol {
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
        print("deinit Select Product Count Coordinator")
    }
    
    func start(animated: Bool) {
        let selectProductCountBuilder = SelectProductCountBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = selectProductCountBuilder.build()
        if #available(iOS 15.0, *) {
            if let presentationController = viewController.presentationController as? UISheetPresentationController {
                if #available(iOS 16.0, *) {
                    presentationController.detents = [
                        .custom { _ in
                            return 665
                        }
                    ]
                } else {
                    presentationController.detents = [.medium()]
                }
            }
        }
        navigationController?.topViewController?.present(
            viewController,
            animated: animated
        )
    }
    
    func finish(
        animated: Bool,
        completion: (() -> Void)?
    ) {
        guard let finishHandler = completion else { return }
        finishHandlers.append(finishHandler)
    }
}

// MARK: - SelectProductCountPresenterOutput
extension SelectProductCountCoordinator: SelectProductCountPresenterOutput {
    func moduleDidUnload() {
        finishHandlers.forEach { $0() }
    }
    
    func goToCartModule() {
        navigationController?.topViewController?.dismiss(animated: true)
    }
}
