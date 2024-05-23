//
//  WelcomeBuilder.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import Swinject

// MARK: - WelcomeBuilder
final class WelcomeBuilder {
    private var moduleOutput: WelcomePresenterOutput?
    
    init(moduleOutput: WelcomePresenterOutput?) {
        self.moduleOutput = moduleOutput
    }
    
    func build() -> UIViewController {
        let presenter = WelcomePresenter(output: moduleOutput)
        let view = WelcomeViewController(output: presenter)
        presenter.view = view
        return view
    }
}
