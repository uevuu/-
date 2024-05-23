//
//  PriceFilterView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - PriceFilterView:
final class PriceFilterView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.text = R.string.localizable.price()
        return label
    }()
    
    private lazy var fromLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.text = R.string.localizable.from()
        return label
    }()
    
    lazy var minTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = R.color.blue()
        textField.backgroundColor = R.color.priceFilterTextField()
        textField.font = R.font.robotoRegular(size: 14)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var toLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.text = R.string.localizable.to()
        return label
    }()
    
    lazy var maxTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textColor = R.color.blue()
        textField.backgroundColor = R.color.priceFilterTextField()
        textField.font = R.font.robotoRegular(size: 14)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fromLabel,
            minTextField,
            toLabel,
            maxTextField
        ])
        stackView.setCustomSpacing(10, after: fromLabel)
        stackView.setCustomSpacing(25, after: minTextField)
        stackView.setCustomSpacing(10, after: toLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        return view
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 112))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(priceStackView)
        addSubview(bottomLine)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(16)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().offset(16)
        }
        minTextField.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(90)
        }
        
        maxTextField.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.width.equalTo(90)
        }
        bottomLine.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(13)
        }
    }
}
