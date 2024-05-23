//
//  CartViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit

// MARK: - CartViewController
class CartViewController: UIViewController {
    private let output: CartViewOutput
    
    // MARK: - UI
    private lazy var deleteSelectedButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.error(), for: .normal)
        button.setTitle(R.string.localizable.deleteSelected(), for: .normal)
        button.titleLabel?.font = R.font.robotoRegular(size: 14)
        button.addTarget(self, for: #selector(deleteSelectedButtonTapped))
        return button
    }()
    
    private lazy var selectAllButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.blue(), for: .normal)
        button.setTitle(R.string.localizable.selectAll(), for: .normal)
        button.titleLabel?.font = R.font.robotoRegular(size: 14)
        button.addTarget(self, for: #selector(selectAllButtonTapped))
        button.imageEdgeInsets.left = -8
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            deleteSelectedButton,
            selectAllButton
        ])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var productsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.register(ProductInCartTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset.bottom = 70
        return tableView
    }()
    
    private lazy var proceedToCheckoutButton = SimpleButton(title: R.string.localizable.proceedToCheckout())
    
    // MARK: - Init
    
    init(output: CartViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Cart view")
        output.deinitEvent()
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewDidLoadEvent()
        configureNavigationBar()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        proceedToCheckoutButton.addTarget(self, for: #selector(proceedToCheckoutButtonTapped))
        view.addSubview(topStackView)
        view.addSubview(productsTableView)
        view.addSubview(proceedToCheckoutButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.title = R.string.localizable.cart()
    }
    
    private func setConstraints() {
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(55)
        }
        productsTableView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        proceedToCheckoutButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(21)
        }
    }
    
    // MARK: - Private
    @objc private func deleteSelectedButtonTapped() {
        output.deleteSelected()
    }
    
    @objc private func selectAllButtonTapped() {
        output.selectAll()
    }
    
    @objc private func proceedToCheckoutButtonTapped() {
        output.proceedToCheckout()
    }
    
    @objc private func selectButtonTapped(_ sender: ProductInCartTableViewCell) {
        output.selectProduct(at: sender.tag)
    }
    
    @objc private func countButtonTapped(_ sender: ProductInCartTableViewCell) {
        output.selectCount(at: sender.tag)
    }
    
    @objc private func deleteButtonTapped(_ sender: ProductInCartTableViewCell) {
        let optionMenu = UIAlertController(
            title: nil,
            message: R.string.localizable.deleteProductWarning(),
            preferredStyle: .actionSheet
        )
        optionMenu.addDestructive(title: R.string.localizable.deleteProduct()) { [weak output] _ in
            output?.deleteProduct(at: sender.tag)
        }
        present(
            optionMenu,
            animated: true,
            completion: nil
        )
    }
}

// MARK: - CartViewInput
extension CartViewController: CartViewInput {
    func reloadCart() {
        productsTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getItemsInCartCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(ProductInCartTableViewCell.self, for: indexPath)
        cell.selectedButton.tag = indexPath.item
        cell.selectedButton.addTarget(self, for: #selector(selectButtonTapped(_:)))
        cell.countButton.addTarget(self, for: #selector(countButtonTapped(_:)))
        cell.countButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, for: #selector(deleteButtonTapped(_:)))
        cell.deleteButton.tag = indexPath.item
        output.configureCell(cell, at: indexPath)
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectProduct(at: indexPath)
    }
}
