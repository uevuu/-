//
//  UINavigationController+Extensions.swift
//  MarketPlace
//
//  Created by Nikita Marin on 04.07.2023.
//

import UIKit

extension UINavigationController {
    func addBottomLine(with color: UIColor?) {
        let bottomLineView = UIView(frame: CGRect(
            x: 0,
            y: navigationBar.frame.size.height,
            width: view.frame.size.width,
            height: 2
        ))
        bottomLineView.backgroundColor = R.color.placeholderBottomLine()
        navigationBar.addSubview(bottomLineView)
    }
}
