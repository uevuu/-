//
//  RegisterButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit
import SnapKit

// MARK: - RegisterButton
final class RegisterButton: UIButton {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = R.color.blue()
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
        backgroundColor = R.color.registerButton()
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
}
