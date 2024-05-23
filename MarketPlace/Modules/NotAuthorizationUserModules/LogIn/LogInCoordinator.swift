//
//  LogInCoordinator.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - LogInCoordinator
final class LogInCoordinator: FlowCoordinatorProtocol {
    private let resolver: Resolver
    private weak var navigationController: UINavigationController?
    weak var delegate: WelcomeCoordinatorFinishDelegate?
    
    init(
        resolver: Resolver,
        navigationController: UINavigationController?
    ) {
        self.resolver = resolver
        self.navigationController = navigationController
    }
    
    deinit {
        print("deinit loginCoor")
    }
    
    func start(animated: Bool) {
        let builder = LogInBuilder(
            resolver: resolver,
            moduleOutput: self
        )
        let viewController = builder.build()
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func finish(animated: Bool, completion: (() -> Void)?) {
    }
}

// MARK: - LogInPresenterOutput
extension LogInCoordinator: LogInPresenterOutput {
    func goToPreviousModule() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToUserModule() {
        delegate?.welcomeCoordinatorDidFinish()
    }
}
