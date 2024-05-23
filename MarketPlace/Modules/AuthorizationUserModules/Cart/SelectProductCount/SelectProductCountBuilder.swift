//
//  SelectProductCountBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectProductCountBuilder
final class SelectProductCountBuilder {
    private let resolver: Resolver
    private var moduleOutput: SelectProductCountPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: SelectProductCountPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = SelectProductCountPresenter(
            output: moduleOutput,
            cartService: resolver.resolve(),
            productLocalDataSources: resolver.resolve()
        )
        let view = SelectProductCountViewController(output: presenter)
        presenter.view = view
        return view
    }
}
