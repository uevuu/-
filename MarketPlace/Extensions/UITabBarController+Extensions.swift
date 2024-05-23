//
//  UITabBarController+Extensions.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

extension UITabBarController {
    func addViewController(
        viewController: UIViewController,
        title: String? = nil,
        image: UIImage?
    ) {
        viewController.title = title
        viewController.tabBarItem.image = image
        var viewControllers = self.viewControllers ?? []
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: true)
    }
}
