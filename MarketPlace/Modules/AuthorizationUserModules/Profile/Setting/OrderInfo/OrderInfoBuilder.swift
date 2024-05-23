//
//  OrderInfoBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit
import Swinject

// MARK: - OrderInfoBuilder
final class OrderInfoBuilder {
    private let resolver: Resolver
    private var moduleOutput: OrderInfoPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: OrderInfoPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = OrderInfoPresenter(output: moduleOutput)
        let view = OrderInfoViewController(output: presenter)
        presenter.view = view
        return view
    }
}
