//
//  ProductInfoView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit
protocol ProductInfoViewControllerDelegate: AnyObject {
    func makeButtonPressed()
    func makeButtonNotPressed()
}

// MARK: - ProductInfoView
final class ProductInfoView: UICollectionReusableView {
    private lazy var titleView = TitleViewForProduct()
    private lazy var descriptionPriceView = DescriptionPriceViewForProduct()
    lazy var addToCartButton = SimpleButton(title: R.string.localizable.addToCart())
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleView,
            descriptionPriceView,
            addToCartButton
        ])
        stackView.setCustomSpacing(14, after: titleView)
        stackView.setCustomSpacing(30, after: descriptionPriceView)
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
        addSubview(stackView)
        setConstraints()
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configureCell(
        title: String,
        sellerName: String,
        price: String,
        description: String
    ) {
        titleView.titleLabel.text = title
        titleView.sellerNameLabel.text = sellerName
        descriptionPriceView.priceLabel.text = price
        descriptionPriceView.descriptionLabel.text = description
    }
}

// MARK: - ProductInfoViewControllerDelegate
extension ProductInfoView: ProductInfoViewControllerDelegate {
    func makeButtonPressed() {
        addToCartButton.label.text = R.string.localizable.removeFromCart()
        addToCartButton.label.textColor = R.color.notReadyFont()
        addToCartButton.backgroundColor = R.color.notReadyButton()
    }
    
    func makeButtonNotPressed() {
        addToCartButton.label.text = R.string.localizable.addToCart()
        addToCartButton.label.textColor = .white
        addToCartButton.backgroundColor = R.color.blue()
    }
}
