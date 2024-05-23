//
//  WelcomeViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 03.07.2023.
//

import UIKit

protocol WelcomeCoordinatorFinishDelegate: AnyObject {
    func welcomeCoordinatorDidFinish()
}

// MARK: - WelcomeViewController
class WelcomeViewController: UIViewController {
    private let output: WelcomeViewOutput
    
    // MARK: - UI
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.welcomeText()
        label.font = R.font.robotoRegular(size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton = SimpleButton(title: R.string.localizable.logIn())
    private lazy var registerButton = RegisterButton(title: R.string.localizable.signUp())
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            loginButton,
            registerButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    init(output: WelcomeViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit welcome view")
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.backgroundColor = R.color.background()
        view.addSubview(welcomeLabel)
        view.addSubview(buttonStackView)
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        registerButton.addTarget(
            self,
            action: #selector(registerButtonTapped),
            for: .touchUpInside
        )
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.logInAndRegistration()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
    }
    
    private func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Private
    
    @objc private func loginButtonTapped() {
        output.logInTapped()
    }
    
    @objc private func registerButtonTapped() {
        output.signUpTapped()
    }
}

// MARK: - WelcomeViewInput
extension WelcomeViewController: WelcomeViewInput {
}
