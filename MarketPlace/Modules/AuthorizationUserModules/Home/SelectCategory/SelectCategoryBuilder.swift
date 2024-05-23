//
//  SelectCategoryBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectCategoryBuilder
final class SelectCategoryBuilder {
    private let resolver: Resolver
    private var moduleOutput: SelectCategoryPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: SelectCategoryPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = SelectCategoryPresenter(
            output: moduleOutput
        )
        let view = SelectCategoryViewController(output: presenter)
        presenter.view = view
        return view
    }
}
