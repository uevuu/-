//
//  UILabel+Extensions.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

extension UILabel {
    func setTitle(_ title: String, titleSize: CGFloat = 12) {
        text = "   \(title)   "
        font = R.font.robotoRegular(size: titleSize)
    }
}
