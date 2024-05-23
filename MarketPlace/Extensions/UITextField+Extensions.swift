//
//  UITextField+Extensions.swift
//  MarketPlace
//
//  Created by Nikita Marin on 04.07.2023.
//

import UIKit

extension UITextField {
    func setPlaceHolderWithSecondaryColor(_ placeholder: String) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: R.color.textFieldFont() ?? .gray]
        )
    }
}
