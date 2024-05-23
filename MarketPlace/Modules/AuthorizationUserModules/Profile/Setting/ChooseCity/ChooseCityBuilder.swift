//
//  ChooseCityBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit
import Swinject

// MARK: - ChooseCityBuilder
final class ChooseCityBuilder {
    private let resolver: Resolver
    private var moduleOutput: ChooseCityPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: ChooseCityPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = ChooseCityPresenter(
            output: moduleOutput,
            daDataApiService: resolver.resolve()
        )
        let view = ChooseCityViewController(output: presenter)
        presenter.view = view
        return view
    }
}
