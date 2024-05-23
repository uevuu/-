//
//  UIAlertController+Extensions .swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.11.2023.
//

import UIKit

// MARK: - UIAlertController
extension UIAlertController {
    func addDestructive(title: String, confirmAction: @escaping (UIAlertAction) -> Void) {
        let deleteAction = UIAlertAction(
            title: title,
            style: .destructive,
            handler: confirmAction
        )
        let cancelAction = UIAlertAction(
            title: R.string.localizable.cancel(),
            style: .cancel
        )
        addAction(deleteAction)
        addAction(cancelAction)
    }
}
