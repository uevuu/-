//
//  DeleteProductImageCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - DeleteProductImageCell
final class DeleteProductImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "trash"),
            for: .normal
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 20 / 2
        button.backgroundColor = .white
        button.tintColor = R.color.blue()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(2)
            make.height.width.equalTo(20)
        }
    }
    
    func configureCell(imageUrl: String) {
        imageView.image = UIImage(named: imageUrl)
    }
}
