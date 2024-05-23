//
//  FilterViewController .swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - FilterViewController
class FilterViewController: UIViewController {
    private let output: FilterViewOutput
    
    // MARK: - UI
    
    private lazy var priceFilterView = PriceFilterView()
    
    private lazy var filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = priceFilterView
        tableView.contentInset.bottom = 70
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var applyButton = SimpleButton(title: R.string.localizable.apply())

    // MARK: - Init
    
    init(output: FilterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Filter view")
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
        applyButton.addTarget(self, for: #selector(applyButtonTapped))
        priceFilterView.minTextField.delegate = self
        priceFilterView.maxTextField.delegate = self
        view.addSubview(filterTableView)
        view.addSubview(applyButton)
        view.backgroundColor = R.color.background()
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.filters()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        filterTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        applyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(21)
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func applyButtonTapped() {
        output.applyTapped()
    }
}

// MARK: - ChooseCityViewInput
extension FilterViewController: FilterViewInput {
    func reloadFilter() {
        filterTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
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
        cell.selectionStyle = .none
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectCategory(at: indexPath)
    }
}

// MARK: - UITextFieldDelegate
extension FilterViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        if textField.text?.isEmpty == true && string == "0" {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
