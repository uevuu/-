//
//  OrderTableViewCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - OrderTableViewCell
class OrderTableViewCell: UITableViewCell {
    private lazy var dataInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 14)
        return label
    }()
    
    private lazy var priceInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        return label
    }()
    
    private lazy var forwardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: R.string.systemImage.forward())
        imageView.tintColor = R.color.secondary()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            dataInfoLabel,
            priceInfoLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageViews: [UIImageView] = (0..<5).map { _ in UIImageView() }
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.spacing = 10
        stackView.distribution = .fillEqually
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
        imageViews.forEach { imageView in
            imageView.contentMode = .scaleAspectFill
        }
        contentView.addSubview(textStackView)
        contentView.addSubview(forwardImageView)
        contentView.addSubview(imageStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        forwardImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18)
            make.height.equalTo(22)
            make.width.equalTo(12)
            make.centerY.equalTo(textStackView.snp.centerY)
        }
        textStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalTo(forwardImageView.snp.leading).inset(10)
        }
        let imageHeight = ((contentView.bounds.width - 74) * 65) / (48 * 5)
        imageStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(35)
            make.height.equalTo(imageHeight)
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(14)
        }
    }
    
    func configureCell(
        dataInfo: String,
        priceInfo: String,
        imageUrls: [String]
    ) {
        dataInfoLabel.text = "Заказ от \(dataInfo)"
        priceInfoLabel.text = "На сумму \(priceInfo) б."
        for (imageView, imageUrl) in zip(imageViews, imageUrls) {
            imageView.image = UIImage(named: imageUrl)
        }
    }
}
