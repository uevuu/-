//
//  SettingTableViewCell.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - SettingTableViewCell
class SettingTableViewCell: UITableViewCell {    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var helpLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 14)
        label.textColor = R.color.blue()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = R.color.secondary()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(bottomLine)
        contentView.addSubview(titleLabel)
        contentView.addSubview(helpLabel)
        contentView.addSubview(iconImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        bottomLine.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.centerY.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }
        helpLabel.snp.makeConstraints { make in
            make.trailing.equalTo(iconImageView.snp.leading)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureCell(
        title: String,
        helpData: String? = nil
    ) {
        titleLabel.text = title
        helpLabel.text = helpData
    }
}
