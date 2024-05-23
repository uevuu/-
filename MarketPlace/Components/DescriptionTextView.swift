//
//  DescriptionTextView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - DescriptionTextView:
final class DescriptionTextView: UIView {
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = R.font.robotoRegular(size: 14)
        textView.backgroundColor = R.color.background()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        label.textColor = R.color.textFieldFont()
        label.text = R.string.localizable.description()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var maxCharLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.robotoRegular(size: 12)
        label.textColor = R.color.textFieldFont()
        label.text = R.string.localizable.maximumCharacters()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(bottomLine)
        addSubview(maxCharLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(2)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(125)
        }
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(textView.snp.bottom)
            make.height.equalTo(2)
        }
        maxCharLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(5)
            make.trailing.bottom.equalToSuperview()
        }
    }
}
