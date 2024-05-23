//
//  HomeViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    private let output: HomeViewOutput
    
    // MARK: UI
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.register(ProductCell.self)
        collectionView.backgroundColor = R.color.background()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset.left = 8
        layout.sectionInset.right = 8
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 24) / 2
        let itemHeight = 293 * itemWidth / 175
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        return layout
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searсhBar = UISearchBar()
        searсhBar.searchTextField.font = R.font.robotoRegular(size: 14)
        searсhBar.searchTextField.clearButtonMode = .never
        searсhBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: R.string.localizable.productName(),
            attributes: [
                .foregroundColor: R.color.secondary() ?? UIColor.gray,
                .font: R.font.robotoRegular(size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )
        searсhBar.delegate = self
        return searсhBar
    }()
    
    private lazy var addProductButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: R.string.systemImage.plus()),
            for: .normal
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 50 / 2
        button.backgroundColor = R.color.plusBackground()
        button.addTarget(self, for: #selector(addProductButtonTapped))
        button.tintColor = R.color.blue()
        return button
    }()
    
    // MARK: Init
    init(
        output: HomeViewOutput,
        isSeller: Bool = false
    ) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        addProductButton.isHidden = !isSeller
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Home view")
        output.deinitEvent()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoadEvent()
        configureNavigationBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.resignFirstResponder()
    }
    
    // MARK: Setup
    private func setup() {
        view.backgroundColor = R.color.background()
        view.addSubview(collectionView)
        view.addSubview(addProductButton)
        setConstraints()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = R.color.secondary()
        navigationItem.titleView = searchBar
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        addProductButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    // MARK: Private
    @objc private func filterButtonTapped() {
        output.filterTapped()
    }
    
    @objc private func addProductButtonTapped() {
        output.addProductTapped()
    }
}

// MARK: - HomeViewInput
extension HomeViewController: HomeViewInput {
    func reloadView() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getProductsCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ProductCell.self, for: indexPath)
        output.configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        output.selectProduct(at: indexPath)
    }
}

// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        output.handleTextInput(searchText)
    }
}
