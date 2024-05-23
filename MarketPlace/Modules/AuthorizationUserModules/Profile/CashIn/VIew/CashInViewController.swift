//
//  CashInViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - CashInViewController
final class CashInViewController: UIViewController {
    private let output: CashInViewOutput
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.enterAmount()
        label.font = R.font.robotoRegular(size: 15)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = R.font.robotoRegular(size: 14)
        textField.setPlaceHolderWithSecondaryColor(R.string.localizable.pointsCount())
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cashInButton = SimpleButton(title: R.string.localizable.cashIn())
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            textField,
            cashInButton
        ])
        stackView.axis = .vertical
        stackView.setCustomSpacing(20, after: titleLabel)
        stackView.setCustomSpacing(43, after: textField)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    init(output: CashInViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        output.deinitEvent()
        print("deinit Cash In view")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        cashInButton.addTarget(
            self,
            action: #selector(cashIndButtonTapped),
            for: .touchUpInside
        )
        textField.addSubview(bottomLine)
        view.addSubview(stackView)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        bottomLine.snp.makeConstraints { make in
            make.width.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Private
    @objc private func cashIndButtonTapped() {
        output.cashIn(points: textField.text ?? "")
        dismiss(animated: true)
    }
}

// MARK: - CashInViewInput
extension CashInViewController: CashInViewInput {
}

// MARK: - UITextFieldDelegate
extension CashInViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        if textField.text?.isEmpty == true && string == "0" {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
