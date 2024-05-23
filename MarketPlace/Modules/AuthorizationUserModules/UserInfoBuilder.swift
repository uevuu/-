//
//  UserInfoBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit
import Swinject

// MARK: - UserInfoBuilder
final class UserInfoBuilder {
    private let resolver: Resolver
    private var moduleOutput: UserInfoPresenterOutput?
    
    init(
        resolver: Resolver,
        moduleOutput: UserInfoPresenterOutput?
    ) {
        self.resolver = resolver
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = UserInfoPresenter(
            output: moduleOutput,
            userInfoService: resolver.resolve()
        )
        let view = UserInfoViewController(output: presenter)
        presenter.view = view
        return view
    }
}
