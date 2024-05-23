//
//  ProductCountView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit

// MARK: - ProductCountView:
final class ProductCountView: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = R.color.blue()
        textField.setPlaceHolderWithSecondaryColor(R.string.localizable.productCount())
        textField.font = R.font.robotoRegular(size: 14)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.productCount()
        label.font = R.font.robotoRegular(size: 12)
        label.textColor = R.color.textFieldFont()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var helpLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        label.textColor = R.color.textFieldFont()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 20, y: 0, width: 0, height: 60))
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textField.addTarget(
            self,
            action: #selector(textFieldTextChanged),
            for: .editingChanged
        )
        addSubview(textField)
        addSubview(titleLabel)
        addSubview(bottomLine)
        addSubview(helpLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(1)
        }
        
        helpLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(5)
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc private func textFieldTextChanged() {
        titleLabel.isHidden = textField.text?.isEmpty ?? true
    }

    func getInputText() -> String {
        return textField.text ?? ""
    }
    
    func setCount(_ count: Int) {
        helpLabel.text = "\(R.string.localizable.remain()) \(count) шт."
    }
}
