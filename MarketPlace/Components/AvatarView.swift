//
//  AvatarView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - AvatarView
final class AvatarView: UIView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .gray
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: R.string.systemImage.person())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addPhotoButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: R.string.systemImage.camera()),
            for: .normal
        )
        button.backgroundColor = R.color.blue()
        button.tintColor = .white
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .red
        addSubview(imageView)
        addSubview(addPhotoButton)
        setConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.width.equalTo(131)
        }
        addPhotoButton.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.bottom)
            make.centerX.equalTo(imageView.snp.trailing)
            make.height.width.equalTo(43)
        }
    }
}
