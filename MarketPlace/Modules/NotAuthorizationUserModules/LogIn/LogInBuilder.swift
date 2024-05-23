//
//  LogInBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - LogInBuilder
final class LogInBuilder {
    private let resolver: Resolver
    private var moduleOutput: LogInPresenterOutput?
    
    init(resolver: Resolver, moduleOutput: LogInPresenterOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = LogInPresenter(
            output: moduleOutput,
            logInService: resolver.resolve()
        )
        let view = LogInViewController(output: presenter)
        presenter.view = view
        return view
    }
}
