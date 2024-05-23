//
//  EditProductBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit
import Swinject

// MARK: - EditProductBuilder
final class EditProductBuilder {
    private let resolver: Resolver
    private var moduleOutput: EditProductPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: EditProductPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = EditProductPresenter(output: moduleOutput)
        let view = EditProductViewController(output: presenter)
        presenter.view = view
        return view
    }
}
