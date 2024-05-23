//
//  SelectProductCountViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit

// MARK: - SelectProductCountViewController
final class SelectProductCountViewController: UIViewController {
    private let output: SelectProductCountViewOutput
    
    // MARK: UI
    
    private lazy var selectCountLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.selectCount()
        label.font = R.font.robotoRegular(size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.background()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = productCountTextField
        return tableView
    }()
    
    private lazy var productCountTextField = ProductCountView()
    private lazy var readyButton = SimpleButton(title: R.string.localizable.ready())
    
    // MARK: Init
    
    init(output: SelectProductCountViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        output.deinitEvent()
        print("deinit Select Product Count view")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let remainCount = output.getRemainCount()
        productCountTextField.setCount(remainCount)
        productCountTextField.textField.delegate = self
        readyButton.addTarget(self, for: #selector(readyButtonTapped))
        productCountTextField.textField.addTarget(
            self,
            action: #selector(textFieldTextChanged),
            for: .editingChanged
        )
        view.backgroundColor = R.color.background()
        view.addSubview(tableView)
        view.addSubview(selectCountLabel)
        view.addSubview(readyButton)
        setConstraints()
    }
    
    private func setConstraints() {
        selectCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(16)
        }
        readyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(45)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(selectCountLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(readyButton.snp.top).inset(65)
        }
    }
    
    // MARK: Private
    @objc private func cashIndButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func readyButtonTapped() {
        output.readyTapped(with: productCountTextField.getInputText())
    }
    
    @objc private func textFieldTextChanged() {
        output.handleTextInput(productCountTextField.getInputText())
    }
    
    // MARK: Close keyboard when tap outside
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - SelectProductCountViewInput
extension SelectProductCountViewController: SelectProductCountViewInput {
    func reloadCount(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .none)
    }
    
    func setUncheck(at indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func setCheck(at indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    func clearTextField() {
        productCountTextField.textField.text = ""
    }
}

// MARK: - UITableViewDataSource
extension SelectProductCountViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return output.getTableRowCount()
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
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 45
    }
}

// MARK: - UITableViewDelegate
extension SelectProductCountViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        output.selectCount(at: indexPath)
    }
}

// MARK: - UITextFieldDelegate
extension SelectProductCountViewController: UITextFieldDelegate {
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
