//
//  MyOrdersViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - MyOrdersViewController
class MyOrdersViewController: UIViewController {
    private let output: MyOrdersViewOutput
    
    // MARK: - UI
    
    private lazy var ordersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.register(OrderTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Init
    
    init(
        output: MyOrdersViewOutput,
        isSeller: Bool = false
    ) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        !isSeller ? navigationItem.leftBarButtonItem = BackBarButton() : nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit My Orders view")
        output.deinitEvent()
    }
    
    // MARK: - Lifecycle
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        view.addSubview(ordersTableView)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = R.string.localizable.orders()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        ordersTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
}

// MARK: - MyOrderViewController
extension MyOrdersViewController: MyOrdersViewInput {
}

// MARK: - UITableViewDataSource
extension MyOrdersViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getOrdersCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(OrderTableViewCell.self, for: indexPath)
        output.configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MyOrdersViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectOrder(at: indexPath)
    }
}
