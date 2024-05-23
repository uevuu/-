//
//  CreateProductBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit
import Swinject

// MARK: - CreateProductBuilder
final class CreateProductBuilder {
    private let resolver: Resolver
    private var moduleOutput: CreateProductPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: CreateProductPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = CreateProductPresenter(output: moduleOutput)
        let view = CreateProductViewController(output: presenter)
        presenter.view = view
        return view
    }
}
