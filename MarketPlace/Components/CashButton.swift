//
//  CashButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - CashButton
final class CashButton: UIButton {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = .white
        label.text = R.string.localizable.cashIn()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.blue()
        addSubview(label)
        clipsToBounds = true
        layer.cornerRadius = 5
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(33)
            make.trailing.equalToSuperview().inset(33)
        }
    }
}
