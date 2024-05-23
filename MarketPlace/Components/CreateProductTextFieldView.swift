//
//  CreateProductTextFieldView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - CreateProductTextFieldView:
final class CreateProductTextFieldView: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = R.font.robotoRegular(size: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
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
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        textField.setPlaceHolderWithSecondaryColor(title)
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
        setConstraints()
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    }
    
    @objc private func textFieldTextChanged() {
        titleLabel.isHidden = textField.text?.isEmpty ?? true
    }
}
