//
//  SelectCategoryViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - SelectCategoryViewController
class SelectCategoryViewController: UIViewController {
    private let output: SelectCategoryViewOutput
    
    // MARK: - UI
    
    private lazy var categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset.bottom = 70
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var readyButton = SimpleButton(title: R.string.localizable.ready())

    // MARK: - Init
    
    init(output: SelectCategoryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Select Category view")
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
        readyButton.addTarget(self, for: #selector(readyButtonTapped))
        view.addSubview(categoryTableView)
        view.addSubview(readyButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.choosingcCategory()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        readyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(21)
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func readyButtonTapped() {
        output.readyTapped()
    }
}

// MARK: - SelectCategoryViewInput
extension SelectCategoryViewController: SelectCategoryViewInput {
    func reloadCategory() {
        categoryTableView.reloadData()
    }
    
    func enableButton() {
        readyButton.makeDefault()
    }
    
    func disableButton() {
        readyButton.makeNotReady()
    }
}

// MARK: - UITableViewDataSource
extension SelectCategoryViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getFilterCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = R.font.robotoRegular(size: 14)
        cell.tintColor = R.color.blue()
        cell.backgroundColor = .clear
        
        let imageView = UIImageView(image: UIImage(systemName: "circle"))
        cell.textLabel?.text = "Категория"
        cell.textLabel?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset((indexPath.item + 1) * 17)
        }
        cell.accessoryView = imageView
        cell.selectionStyle = .none
        
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDelegate
extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectCategory(at: indexPath)
    }
}
