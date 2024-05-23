//
//  UIButton+Extensions.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

extension UIButton {
    func addTarget<T: Any>(
        _ target: T,
        for action: Selector,
        event: UIControl.Event = .touchUpInside
    ) {
        addTarget(target, action: action, for: event)
    }
    
    func setTitle(_ title: String, titleSize: CGFloat = 13) {
        self.setTitle(title, for: .normal)
        titleLabel?.font = R.font.robotoRegular(size: titleSize)
    }
}
