//
//  LogInViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

// MARK: - LogInViewController
class LogInViewController: UIViewController {
    private let output: LogInViewOutput
    
    // MARK: - UI
    
    private lazy var emailOrPhoneView = CustomTextFieldView(title: R.string.localizable.emailOrPhoneNumber())
    private lazy var passwordView = CustomTextFieldView(title: R.string.localizable.password(), type: .password)
    private lazy var textFiledsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            emailOrPhoneView,
            passwordView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var logInButton = SimpleButton(title: R.string.localizable.logIn())

    // MARK: - Init
    
    init(output: LogInViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit login view")
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        view.addSubview(textFiledsStackView)
        view.addSubview(logInButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.logIn()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        textFiledsStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(27)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(textFiledsStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func logInButtonTapped() {
        output.logInTapped(
            emailOrPhone: emailOrPhoneView.getInputText(),
            password: passwordView.getInputText()
        )
    }
}

// MARK: - LogInViewInput
extension LogInViewController: LogInViewInput {
    func showPhoneNumberOrEmailValidationError() {
        emailOrPhoneView.fieldError(name: R.string.localizable.incorrectFormat())
    }
    
    func showUserExistError() {
        emailOrPhoneView.fieldError(name: R.string.localizable.emailOrPhoneNumberNotExist())
    }
    
    func showPasswordError() {
        passwordView.fieldError(name: R.string.localizable.incorrectPassword())
    }
    
    func showEmptyEmailOrPhoneError() {
        emailOrPhoneView.existError()
    }
    
    func showEmptyPasswordError() {
        passwordView.existError()
    }
    
    func hideUserExistError() {
        emailOrPhoneView.isCorrect()
    }
    
    func hidePasswordError() {
        passwordView.isCorrect()
    }
}
