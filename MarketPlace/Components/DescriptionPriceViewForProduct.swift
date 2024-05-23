//
//  DescriptionPriceViewForProduct.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - DescriptionPriceViewForProduct
final class DescriptionPriceViewForProduct: UIView {
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoBold(size: 16)
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.description()
        label.font = R.font.robotoRegular(size: 18)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            priceLabel,
            descriptionTitleLabel,
            descriptionLabel
        ])
        stackView.setCustomSpacing(18, after: priceLabel)
        stackView.setCustomSpacing(12, after: descriptionTitleLabel)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        setConstraints()
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
