//
//  CustomTextFieldButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

final class CustomTextFieldButton: UIButton {
    private lazy var textField = CustomTextFieldView(
        title: R.string.localizable.password(),
        type: .password,
        text: "--------"
    )
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: R.string.systemImage.chevronRight())
        imageView.tintColor = R.color.secondary()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textField.isUserInteractionEnabled = false
        addSubview(textField)
        addSubview(arrowImageView)
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
            make.trailing.equalToSuperview().inset(6)
        }
    }
}
