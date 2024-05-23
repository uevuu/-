//
//  SimpleButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import SnapKit

// MARK: - SimpleButton
final class SimpleButton: UIButton {
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        label.text = title
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.blue()
        addSubview(label)
        clipsToBounds = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func makeNotReady() {
        isEnabled = false
        label.textColor = R.color.notReadyFont()
        backgroundColor = R.color.notReadyButton()
    }
    
    func makeDefault() {
        isEnabled = true
        label.textColor = .white
        backgroundColor = R.color.blue()
    }
}
