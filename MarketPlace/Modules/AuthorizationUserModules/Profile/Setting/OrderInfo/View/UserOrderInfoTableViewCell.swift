//
//  UserOrderInfoTableViewCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - UserOrderInfoTableViewCell
class UserOrderInfoTableViewCell: UITableViewCell {
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = R.color.blue()
        label.textColor = R.color.background()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        return label
    }()
    
    private lazy var sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = R.color.secondary()
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 16)
        return label
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.blue(), for: .normal)
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            statusLabel,
            titleLabel,
            sellerNameLabel,
            countLabel,
            priceLabel
        ])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.setCustomSpacing(7, after: statusLabel)
        stackView.setCustomSpacing(7, after: sellerNameLabel)
        stackView.setCustomSpacing(17, after: countLabel)
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
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(productImageView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(actionButton)
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
        infoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        actionButton.snp.makeConstraints { make in
            make.leading.equalTo(infoStackView.snp.leading)
            make.bottom.equalTo(productImageView.snp.bottom)
        }
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    func configureCell(
        title: String,
        seller: String,
        count: String,
        price: String,
        imageUrlString: String
    ) {
        statusLabel.setTitle("Новый")
        titleLabel.text = title
        sellerNameLabel.text = seller
        countLabel.text = count
        priceLabel.text = price
        actionButton.setTitle("Отменить товар", titleSize: 14)
        productImageView.image = UIImage(named: imageUrlString)
    }
}
