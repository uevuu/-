//
//  SignUpViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

// MARK: - SignUpViewController
class SignUpViewController: UIViewController {
    private let output: SignUpViewOutput
    
    // MARK: - UI
    
    private lazy var firstNameView = CustomTextFieldView(title: R.string.localizable.firstName())
    private lazy var lastNameView = CustomTextFieldView(title: R.string.localizable.lastName())
    private lazy var emailView = CustomTextFieldView(title: R.string.localizable.email())
    private lazy var phoneNumberView = CustomTextFieldView(title: R.string.localizable.phoneNumber())
    private lazy var passwordView = CustomTextFieldView(title: R.string.localizable.password(), type: .password)
    private lazy var sellerSwitchView = SellerSwitchView(title: R.string.localizable.iAmSeller())
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            firstNameView,
            lastNameView,
            emailView,
            phoneNumberView,
            passwordView,
            sellerSwitchView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var signUpButton = SimpleButton(title: R.string.localizable.signUp())

    // MARK: - Init
    
    init(output: SignUpViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit signUp view")
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(userInfoStackView)
        view.addSubview(signUpButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.registration()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(27)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func signUpButtonTapped() {
        output.signUpTapped(signUpData: SignUpData(
            firstName: firstNameView.getInputText(),
            lastName: lastNameView.getInputText(),
            email: emailView.getInputText(),
            phoneNumber: phoneNumberView.getInputText(),
            password: passwordView.getInputText(),
            isSeller: sellerSwitchView.isOn()
        ))
    }
}

// MARK: - SignUpViewInput
extension SignUpViewController: SignUpViewInput {
    func showEmailValidationError() {
        emailView.fieldError(name: R.string.localizable.incorrectFormat())
    }
    
    func showPhoneNumberValidationError() {
        phoneNumberView.fieldError(name: R.string.localizable.incorrectFormat())
    }
    
    func showPasswordValidationError() {
        passwordView.fieldError(name: R.string.localizable.passwordValidation())
    }
    
    func showEmptyFirstNameError() {
        firstNameView.existError()
    }
    
    func showEmptyLastNameError() {
        lastNameView.existError()
    }
    
    func showEmptyEmailError() {
        emailView.existError()
    }
    
    func showEmptyPhoneNumberError() {
        phoneNumberView.existError()
    }
    
    func showEmptyPasswordError() {
        passwordView.existError()
    }
    
    func showSameEmailError() {
        emailView.fieldError(name: R.string.localizable.sameDataError())
    }
    
    func showSamePhoneNumberError() {
        phoneNumberView.fieldError(name: R.string.localizable.sameDataError())
    }
    
    func hideEmailValidationError() {
        emailView.isCorrect()
    }
    
    func hidePhoneNumberValidationError() {
        phoneNumberView.isCorrect()
    }
    
    func hidePasswordValidationError() {
        passwordView.isCorrect()
    }
}
