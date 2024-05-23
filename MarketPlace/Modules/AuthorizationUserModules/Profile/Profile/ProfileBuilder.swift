//
//  ProfileBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Swinject

// MARK: - ProfileBuilder
final class ProfileBuilder {
    private let resolver: Resolver
    private var moduleOutput: ProfilePresenterOutput?
    
    init(resolver: Resolver, moduleOutput: ProfilePresenterOutput?) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = ProfilePresenter(
            output: moduleOutput,
            userInfoService: resolver.resolve()
        )
        let view = ProfileViewController(output: presenter)
        presenter.view = view
        return view
    }
}
