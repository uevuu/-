//
//  ProfileViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit

// MARK: - ProfileViewController
class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    
    // MARK: - UI
    
    private lazy var userInfoButton = MainAccountInfoViewButton()
    private lazy var moneyStatus = UserMoneyStatusView()
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            userInfoButton,
            moneyStatus
        ])
        stackView.axis = .vertical 
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.placeholderBottomLine()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.register(SettingTableViewCell.self)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Init
    
    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Profile view")
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoadEvent()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    
    private func setup() {
        moneyStatus.cashButton.addTarget(self, action: #selector(cashIndButtonTapped), for: .touchUpInside)
        userInfoButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        view.addSubview(infoStackView)
        view.addSubview(separatorLine)
        view.addSubview(settingTableView)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func setConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(29)
            make.height.equalTo(13)
            make.leading.trailing.equalToSuperview()
        }
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Private
    
    @objc private func profileButtonTapped() {
        output.profileTapped()
    }
    
    @objc private func cashIndButtonTapped() {
        output.cashInTapped()
    }
}

// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    func reloadSetting(at indexPath: IndexPath) {
        settingTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func reloadInfo(
        name: String,
        email: String,
        points: Int
    ) {
        userInfoButton.nameLabel.text = name
        userInfoButton.emailLabel.text = email
        moneyStatus.bonusCountLabel.text = "\(points) \(R.string.localizable.points())"
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getSettingCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SettingTableViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectSetting(at: indexPath)
    }
}
