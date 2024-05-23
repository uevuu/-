//
//  CashInBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit
import Swinject

// MARK: - CashInBuilder
final class CashInBuilder {
    private let resolver: Resolver
    private var moduleOutput: CashInPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: CashInPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = CashInPresenter(
            output: moduleOutput,
            userInfoService: resolver.resolve()
        )
        let view = CashInViewController(output: presenter)
        presenter.view = view
        return view
    }
}
