//
//  SelectAddressBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import UIKit
import Swinject

// MARK: - SelectAddressBuilder
final class SelectAddressBuilder {
    private let resolver: Resolver
    private var moduleOutput: SelectAddressPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: SelectAddressPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = SelectAddressPresenter(
            output: moduleOutput,
            daDataApiService: resolver.resolve()
        )
        let view = SelectAddressViewController(output: presenter)
        presenter.view = view
        return view
    }
}
