//
//  UserMoneyStatusView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - UserMoneyStatusView
final class UserMoneyStatusView: UIView {
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.onAccount()
        label.font = R.font.robotoRegular(size: 18)
        return label
    }()
    
    lazy var bonusCountLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoBold(size: 20)
        return label
    }()
    
    lazy var cashButton = CashButton()
        
    private lazy var bonusCountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textLabel,
            bonusCountLabel
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = R.color.background()
        addSubview(bonusCountStackView)
        addSubview(cashButton)
        layer.shadowColor = R.color.mainFont()?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        bonusCountStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        cashButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
