//
//  SelectAddressViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import UIKit

// MARK: - SelectAddressViewController
class SelectAddressViewController: UIViewController {
    private let output: SelectAddressViewOutput
    
    // MARK: UI
    private lazy var searchBar: UISearchBar = {
        let searсhBar = UISearchBar()
        searсhBar.searchTextField.font = R.font.robotoRegular(size: 14)
        searсhBar.searchTextField.clearButtonMode = .never
        searсhBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Выберите адрес доставки",
            attributes: [
                .foregroundColor: R.color.secondary() ?? UIColor.gray,
                .font: R.font.robotoRegular(size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )
        searсhBar.backgroundImage = UIImage()
        searсhBar.delegate = self
        return searсhBar
    }()
    
    private lazy var cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var nextButton = SimpleButton(title: R.string.localizable.next())

    // MARK: Init
    init(output: SelectAddressViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        output.deinitEvent()
        print("deinit select address view")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        nextButton.addTarget(self, for: #selector(nextButtonTapped))
        view.addSubview(searchBar)
        view.addSubview(cityTableView)
        view.addSubview(nextButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.populatedArea()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(21)
        }
    }
    
    // MARK: Private
    @objc private func backButtonTapped() {
        searchBar.resignFirstResponder()
        output.backTapped()
    }
    
    @objc private func nextButtonTapped() {
        print("in future")
    }
}

// MARK: - ChooseCityViewInput
extension SelectAddressViewController: SelectAddressViewInput {
    func reloadData() {
        cityTableView.reloadData()
    }
    
    func reloadCity(at indexPaths: [IndexPath]) {
        cityTableView.reloadRows(at: indexPaths, with: .none)
    }
}

// MARK: - UITableViewDataSource
extension SelectAddressViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getCityCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = R.font.robotoRegular(size: 14)
        cell.tintColor = R.color.blue()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDelegate
extension SelectAddressViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectCity(at: indexPath)
    }
}

// MARK: - UISearchBarDelegate
extension SelectAddressViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        output.handleTextInput(searchText)
    }
}
