//
//  SceneDelegate.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var rootCoordinator: RootCoordinator?
    private var serviceLocator: ServiceLocator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let serviceLocator = ServiceLocator()
        
        self.window = window
        self.serviceLocator = serviceLocator
        self.rootCoordinator = RootCoordinator(window: window, resolver: serviceLocator.getResolver())
        rootCoordinator?.start()
    }
}
