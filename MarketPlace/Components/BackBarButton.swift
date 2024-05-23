//
//  BackBarButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

// MARK: - BackBarButton
final class BackBarButton: UIBarButtonItem {
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        image = UIImage(systemName: "arrow.backward")
        style = .plain
        tintColor = R.color.secondary()
    }
}

// MARK: - DeleteBarButton
final class DeleteBarButton: UIBarButtonItem {
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        image = UIImage(systemName: "trash")
        style = .plain
        tintColor = R.color.secondary()
    }
}
