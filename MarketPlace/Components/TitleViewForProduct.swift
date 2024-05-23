//
//  TitleViewForProduct.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - TitleViewForProduct
final class TitleViewForProduct: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoMedium(size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var sellerNameLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 16)
        label.textColor = R.color.secondary()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            sellerNameLabel
        ])
        stackView.setCustomSpacing(6, after: titleLabel)
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
