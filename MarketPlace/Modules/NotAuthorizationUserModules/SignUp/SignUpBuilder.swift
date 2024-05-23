//
//  SignUpBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - SignUpBuilder
final class SignUpBuilder {
    private let resolver: Resolver
    private var moduleOutput: SignUpPresenterOutput?
    
    init(resolver: Resolver, moduleOutput: SignUpPresenterOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = SignUpPresenter(
            output: moduleOutput,
            signUpService: resolver.resolve()
        )
        let view = SignUpViewController(output: presenter)
        presenter.view = view
        return view
    }
}
