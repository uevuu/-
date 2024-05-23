//
//  UserInfoViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import UIKit

// MARK: - UserInfoViewController
class UserInfoViewController: UIViewController {
    private let output: UserInfoViewOutput
    
    // MARK: UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = R.color.background()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var avatarImageView: UIImageView = {
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
        button.clipsToBounds = true
        button.layer.cornerRadius = 43 / 2
        button.backgroundColor = R.color.blue()
        button.tintColor = .white
        return button
    }()
    
    private lazy var firstNameView = CustomTextFieldView(title: R.string.localizable.firstName())
    private lazy var lastNameView = CustomTextFieldView(title: R.string.localizable.lastName())
    private lazy var patronymicView = CustomTextFieldView(title: R.string.localizable.patronymic())
    private lazy var emailView = CustomTextFieldView(title: R.string.localizable.email())
    private lazy var phoneNumberView = CustomTextFieldView(title: R.string.localizable.phoneNumber())
    private lazy var genderView = CustomTextFieldView(title: R.string.localizable.gender())
    private lazy var birthDateView = CustomTextFieldView(title: R.string.localizable.birthDate())
    private lazy var passwordButton = CustomTextFieldButton()
    
    private lazy var logOutButton = RegisterButton(title: R.string.localizable.logOut())
    private lazy var deleteAccountButton = RegisterButton(title: R.string.localizable.deleteAccount())
    private lazy var buttonHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logOutButton,
            deleteAccountButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var readyButton = SimpleButton(title: R.string.localizable.ready())
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstNameView,
            lastNameView,
            patronymicView,
            emailView,
            phoneNumberView,
            genderView,
            birthDateView,
            passwordButton,
            buttonHorizontalStackView,
            readyButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: Init
    init(output: UserInfoViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit User Info View")
        output.deinitEvent()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoadEvent()
        configureNavigationBar()
        setup()
        setupGestureRecognizer()
    }
    
    // MARK: Setup
    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func setup() {
        view.backgroundColor = R.color.background()
        passwordButton.addTarget(self, for: #selector(passwordButtonTapped))
        logOutButton.addTarget(self, for: #selector(logOutButtonTapped))
        deleteAccountButton.addTarget(self, for: #selector(deleteAccountButtonTapped))
        readyButton.addTarget(self, for: #selector(readyButtonTapped))
        view.addSubview(scrollView)
        scrollView.addSubview(avatarImageView)
        scrollView.addSubview(addPhotoButton)
        scrollView.addSubview(textFieldStackView)
        patronymicView.disableTextEmptyValidation()
        genderView.disableTextEmptyValidation()
        birthDateView.disableTextEmptyValidation()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.myDetails()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(131)
        }
        addPhotoButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView.snp.bottom)
            make.centerX.equalTo(avatarImageView.snp.trailing)
            make.height.width.equalTo(43)
        }
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    // MARK: Private
    @objc private func passwordButtonTapped() {
        print("change password")
    }
    
    @objc private func logOutButtonTapped() {
        let optionMenu = UIAlertController(
            title: nil,
            message: R.string.localizable.logOutWarning(),
            preferredStyle: .actionSheet
        )
        optionMenu.addDestructive(title: R.string.localizable.logOut()) { [weak output] _ in
            output?.logOutTapped()
        }
        present(
            optionMenu,
            animated: true,
            completion: nil
        )
    }
    
    @objc private func deleteAccountButtonTapped() {
        let optionMenu = UIAlertController(
            title: nil,
            message: R.string.localizable.deleteWarning(),
            preferredStyle: .actionSheet
        )
        optionMenu.addDestructive(title: R.string.localizable.delete()) { [weak output] _ in
            output?.deleteAccountTapped()
        }
        present(
            optionMenu,
            animated: true,
            completion: nil
        )
    }
    
    @objc private func readyButtonTapped() {
        output.readyTapped(
            email: emailView.getInputText(),
            name: firstNameView.getInputText(),
            surname: lastNameView.getInputText(),
            patronymic: patronymicView.getInputText(),
            gender: genderView.getInputText(),
            birthDate: birthDateView.getInputText(),
            phone: phoneNumberView.getInputText()
        )
    }
    
    @objc private func backButtonTapped() {
        textFieldStackView.endEditing(true)
        output.backTapped()
    }
    
    // MARK: Close keyboard when tap outside
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UserInfoViewInput
extension UserInfoViewController: UserInfoViewInput {
    func hideReadyButton() {
        readyButton.isHidden = true
    }
    
    func setData(_ userInfo: UserInfo) {
        firstNameView.setTitle(userInfo.name)
        lastNameView.setTitle(userInfo.surname)
        patronymicView.setTitle(userInfo.patronymic)
        emailView.setTitle(userInfo.email)
        phoneNumberView.setTitle(userInfo.phone)
        genderView.setTitle(userInfo.gender)
        birthDateView.setTitle(userInfo.birthDate)
    }
}
