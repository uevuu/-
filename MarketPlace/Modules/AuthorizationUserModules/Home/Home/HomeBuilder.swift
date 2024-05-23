//
//  HomeBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - HomeBuilder
final class HomeBuilder {
    private let isSeller: Bool
    private let resolver: Resolver
    private var moduleOutput: HomePresenterOutput?
    
    init(
        isSeller: Bool = false,
        resolver: Resolver,
        moduleOutput: HomePresenterOutput?
    ) {
        self.isSeller = isSeller
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = HomePresenter(
            output: moduleOutput,
            productsService: resolver.resolve(), 
            productLocalDataSources: resolver.resolve()
        )
        let view = HomeViewController(
            output: presenter,
            isSeller: isSeller
        )
        presenter.view = view
        return view
    }
}
