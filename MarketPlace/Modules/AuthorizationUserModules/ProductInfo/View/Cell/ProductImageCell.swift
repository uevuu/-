//
//  ProductImageCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 08.07.2023.
//

import UIKit
import Kingfisher

// MARK: - ProductImageCell
final class ProductImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        setConstraints()
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCell(imageUrl: String) {
        imageView.kf.setImage(with: URL(string: imageUrl))
    }
}
