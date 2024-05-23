//
//  ProductCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit
import Kingfisher

// MARK: - ProductCell
final class ProductCell: UICollectionViewCell {    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 16)
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
    
    private lazy var productInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            priceLabel,
            titleLabel,
            sellerNameLabel
        ])
        stackView.setCustomSpacing(7, after: priceLabel)
        stackView.axis = .vertical
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
        contentView.addSubview(productInfoStackView)
        contentView.addSubview(productImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        productInfoStackView.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        productImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(59 + 9)
        }
    }
    
    func configureCell(
        imageUrl: String,
        price: Int,
        title: String,
        sellerName: String
    ) {
        productImageView.image = UIImage(named: imageUrl)
        productImageView.kf.setImage(with: URL(string: imageUrl))
        priceLabel.text = "\(price) б."
        titleLabel.text = title
        sellerNameLabel.text = sellerName
    }
}
