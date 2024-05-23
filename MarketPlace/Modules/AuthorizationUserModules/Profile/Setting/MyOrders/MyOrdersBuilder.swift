//
//  MyOrdersBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit
import Swinject

// MARK: - MyOrdersBuilder
final class MyOrdersBuilder {
    private let isSeller: Bool
    private let resolver: Resolver
    private var moduleOutput: MyOrdersPresenterOutput?
    
    init(
        isSeller: Bool = false,
        resolver: Resolver,
        moduleOutput: MyOrdersPresenterOutput?
    ) {
        self.isSeller = isSeller
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = MyOrdersPresenter(output: moduleOutput)
        let view = MyOrdersViewController(
            output: presenter,
            isSeller: isSeller
        )
        presenter.view = view
        return view
    }
}
