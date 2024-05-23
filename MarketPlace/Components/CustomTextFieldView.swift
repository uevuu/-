//
//  CustomTextFieldView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 04.07.2023.
//

import UIKit

// MARK: - CustomTextFieldView:
final class CustomTextFieldView: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = R.font.robotoRegular(size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
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
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        label.textColor = R.color.error()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(
        title: String,
        type: TextFieldType = .text,
        text: String? = nil
    ) {
        super.init(frame: .zero)
        if let text = text {
            titleLabel.isHidden = false
            textField.text = text
        }
        titleLabel.text = title
        textField.setPlaceHolderWithSecondaryColor(title)
        if type == .password {
            textField.isSecureTextEntry = true
        }
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
        addSubview(errorLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(2)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(5)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc private func textFieldTextChanged() {
        titleLabel.isHidden = textField.text?.isEmpty ?? true
        bottomLine.backgroundColor = (textField.text?.isEmpty ?? true) ?
            R.color.error() : R.color.placeholderBottomLine()
        textField.textColor = R.color.mainFont()
    }
    
    func fieldError(name: String) {
        errorLabel.text = name
        textField.textColor = R.color.error()
        bottomLine.backgroundColor = R.color.error()
    }
    
    func existError() {
        bottomLine.backgroundColor = R.color.error()
    }
    
    func getInputText() -> String {
        return textField.text ?? ""
    }
    
    func isCorrect() {
        bottomLine.backgroundColor = R.color.placeholderBottomLine()
        textField.textColor = R.color.mainFont()
        errorLabel.text = nil
    }
    
    func disableTextEmptyValidation() {
        textField.removeTarget(
            self,
            action: #selector(textFieldTextChanged),
            for: .editingChanged
        )
    }
    
    func setTitle(_ title: String?) {
        if let notEmptyTitle = title {
            titleLabel.isHidden = false
            textField.text = title
        }
    }
}
