//
//  OrderInfoPreViewHeader.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - OrderInfoPreViewHeader
final class OrderInfoPreViewHeader: UITableViewHeaderFooterView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.orderAmount()
        label.font = R.font.robotoRegular(size: 20)
        return label
    }()

    private lazy var productsPriceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.goodsWorth()
        label.font = R.font.robotoRegular(size: 12)
        return label
    }()

    private lazy var productsPriceInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        return label
    }()

    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.delivery()
        label.numberOfLines = 0
        label.font = R.font.robotoRegular(size: 12)
        return label
    }()

    private lazy var deliveryInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        return label
    }()

    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.total()
        label.font = R.font.robotoRegular(size: 14)
        return label
    }()

    private lazy var summaryInfoLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        return label
    }()

    private lazy var infoStackView: UIStackView = {
        let productPriceStackView = UIStackView(arrangedSubviews: [
            productsPriceLabel,
            productsPriceInfoLabel
        ])
        productPriceStackView.distribution = .equalSpacing
        let deliveryStackView = UIStackView(arrangedSubviews: [
            deliveryLabel,
            deliveryInfoLabel
        ])
        deliveryStackView.distribution = .equalSpacing
        let summaryStackView = UIStackView(arrangedSubviews: [
            summaryLabel,
            summaryInfoLabel
        ])
        summaryStackView.distribution = .equalSpacing
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            productPriceStackView,
            deliveryStackView,
            summaryStackView
        ])
        stackView.axis = .vertical
        stackView.setCustomSpacing(19, after: titleLabel)
        stackView.setCustomSpacing(3, after: productPriceStackView)
        stackView.setCustomSpacing(16, after: deliveryStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.products()
        label.font = R.font.robotoRegular(size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(infoStackView)
        contentView.addSubview(bottomLine)
        contentView.addSubview(productTitle)
        setConstraints()
    }

    private func setConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(20)
            make.height.equalTo(13)
            make.leading.trailing.equalToSuperview()
        }
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(9)
        }
    }

    func configureHeader(
        address: String,
        price: String
    ) {
        productsPriceInfoLabel.text = price
        deliveryLabel.text = "\(R.string.localizable.delivery()) (\(address))"
        deliveryInfoLabel.text = "0 б."
        summaryInfoLabel.text = price
    }
}
