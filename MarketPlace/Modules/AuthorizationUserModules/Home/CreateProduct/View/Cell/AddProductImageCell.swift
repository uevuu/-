//
//  AddProductImageCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - AddProductImageCell
final class AddProductImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .white
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: R.string.systemImage.camera()),
            for: .normal
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 33 / 2
        button.backgroundColor = R.color.blue()
        button.tintColor = .white
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
        contentView.addSubview(addPhotoButton)
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addPhotoButton.snp.makeConstraints { make in
            make.centerX.equalTo(imageView.snp.trailing)
            make.centerY.equalTo(imageView.snp.bottom)
            make.height.width.equalTo(33)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if  addPhotoButton.frame.minX < point.x &&
            point.x < addPhotoButton.frame.maxX &&
            addPhotoButton.frame.minY < point.y &&
            point.y < addPhotoButton.frame.maxY {
            return addPhotoButton
        }
        return self
    }
}
