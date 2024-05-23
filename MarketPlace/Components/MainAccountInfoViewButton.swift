//
//  MainAccountInfoViewButton.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - MainAccountInfoViewButton
final class MainAccountInfoViewButton: UIButton {
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 16)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = R.color.textFieldFont()
        return label
    }()
    
    private lazy var textInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            emailLabel
        ])
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 2
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
        addSubview(avatarImageView)
        addSubview(textInfoStackView)
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    private func setConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.width.equalTo(45)
        }
        textInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(13)
            make.trailing.centerY.equalToSuperview()
        }
    }
}
