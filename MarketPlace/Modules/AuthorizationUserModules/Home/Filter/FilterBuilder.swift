//
//  FilterBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit
import Swinject

// MARK: - FilterBuilder
final class FilterBuilder {
    private let resolver: Resolver
    private var moduleOutput: FilterPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: FilterPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = FilterPresenter(
            output: moduleOutput,
            categoryService: resolver.resolve()
        )
        let view = FilterViewController(output: presenter)
        presenter.view = view
        return view
    }
}
