//
//  CartBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - CartBuilder
final class CartBuilder {
    private let resolver: Resolver
    private var moduleOutput: CartPresenterOutput?
    
    init(resolver: Resolver, moduleOutput: CartPresenterOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = CartPresenter(
            output: moduleOutput,
            cartService: resolver.resolve(),
            productLocalDataSources: resolver.resolve()
        )
        let view = CartViewController(output: presenter)
        presenter.view = view
        return view
    }
}
