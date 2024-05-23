//
//  ProductInCartTableViewCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit
import Kingfisher

// MARK: - UITableViewDelegate
final class ProductInCartTableViewCell: UITableViewCell {
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 14)
        return label
    }()
    
    private lazy var sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 14)
        label.textColor = R.color.secondary()
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 14)
        label.text = R.string.localizable.count()
        return label
    }()
    
    lazy var countButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.background(), for: .normal)
        button.backgroundColor = R.color.blue()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 9, bottom: 2, right: 9)
        button.sizeToFit()
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 16)
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.delete(), for: .normal)
        button.setTitleColor(R.color.blue(), for: .normal)
        button.titleLabel?.font = R.font.robotoRegular(size: 14)
        button.layer.masksToBounds = true
        button.sizeToFit()
        return button
    }()
    
    lazy var selectedButton: UIButton = {
        let button = UIButton()
        button.tintColor = R.color.blue()
        button.setImage(
            UIImage(systemName: R.string.systemImage.circle()),
            for: .normal
        )
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var countInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            countLabel,
            countButton
        ])
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var titleInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            sellerNameLabel,
            countInfoStackView
        ])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.setCustomSpacing(6, after: sellerNameLabel)
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            priceLabel,
            deleteButton
        ])
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var finalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleInfoStackView,
            bottomStackView
        ])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(productImageView)
        contentView.addSubview(finalStackView)
        titleInfoStackView.addSubview(selectedButton)
        setConstraints()
    }
    
    private func setConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(160).priority(.high)
            make.width.equalTo(124)
            make.bottom.equalToSuperview().inset(14)
        }
        finalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(14)
        }
        selectedButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel.snp.bottom)
        }
        titleLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
        }
    }
    
    func configureCell(
        title: String,
        sellerName: String,
        count: String,
        price: String,
        addedToOrder: Bool,
        imageUrlString: String
    ) {
        titleLabel.text = title
        sellerNameLabel.text = sellerName
        countButton.setTitle(count)
        priceLabel.text = price
        productImageView.kf.setImage(with: URL(string: imageUrlString))
        selectedButton.setImage(
            UIImage(systemName: addedToOrder ? R.string.systemImage.circleInsetFilled() :R.string.systemImage.circle()),
            for: .normal
        )
    }
}
