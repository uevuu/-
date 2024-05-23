//
//  SellerSwitchView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 04.07.2023.
//

import UIKit
import SnapKit

// MARK: - SellerSwitchView
final class SellerSwitchView: UISwitch {
    private lazy var statuSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        statusSwitch.isOn = false
        statusSwitch.onTintColor = R.color.blue()
        statusSwitch.layer.cornerRadius = statusSwitch.frame.height / 2
        statusSwitch.backgroundColor = R.color.secondary()
        statusSwitch.clipsToBounds = true
        statusSwitch.translatesAutoresizingMaskIntoConstraints = false
        return statusSwitch
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = R.color.textFieldFont()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(statuSwitch)
        addSubview(titleLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        statuSwitch.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(statuSwitch.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    func isOn() -> Bool {
        return statuSwitch.isOn
    }
}
