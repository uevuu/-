//
//  CreateProductFooterView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - CreateProductFooterView
final class CreateProductFooterView: UICollectionReusableView {
    lazy var titleTextField = CreateProductTextFieldView(title: R.string.localizable.title())
    lazy var amountTextField = CreateProductTextFieldView(title: R.string.localizable.amount())
    lazy var countTextField = CreateProductTextFieldView(title: R.string.localizable.productCount())
    lazy var descriptionTextView = DescriptionTextView()
    lazy var nextButton = SimpleButton(title: R.string.localizable.next())
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleTextField,
            amountTextField,
            countTextField,
            descriptionTextView,
            nextButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(20, after: nextButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleTextField.textField.delegate = self
        amountTextField.textField.delegate = self
        countTextField.textField.delegate = self
        descriptionTextView.textView.delegate = self
        nextButton.makeNotReady()
        amountTextField.textField.keyboardType = .numberPad
        countTextField.textField.keyboardType = .numberPad
        addSubview(textFieldStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func updateNextButtonState() {
        let allFieldsFilled = [
            titleTextField,
            amountTextField,
            countTextField
        ].allSatisfy { $0.textField.text?.isEmpty == false } && descriptionTextView.textView.hasText
        allFieldsFilled ? nextButton.makeDefault() : nextButton.makeNotReady()
    }
}

// MARK: - UITextFieldDelegate
extension CreateProductFooterView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if textField === amountTextField.textField || textField === countTextField.textField {
            let allowedCharacters = CharacterSet.decimalDigits
            if textField.text?.isEmpty == true && string == "0" {
                return false
            }
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 7500
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateNextButtonState()
    }
}

// MARK: - UITextViewDelegate
extension CreateProductFooterView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateNextButtonState()
    }
}
