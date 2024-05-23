//
//  EditProductViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - EditProductViewController
class EditProductViewController: UIViewController {
    private let output: EditProductViewOutput
    
    // MARK: - UI
    
    private lazy var imageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = R.color.secondary()
        pageControl.currentPageIndicatorTintColor = R.color.blue()
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = ProductInfoCollectionView()
        collectionView.register(ProductImageCell.self)
        collectionView.registerFooter(EditProductInfoFooter.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Init
    
    init(output: EditProductViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Edit Product View")
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
        view.backgroundColor = R.color.background()
        view.addSubview(collectionView)
        collectionView.addSubview(imageControl)
        imageControl.layer.zPosition = 1
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.productDescription()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.rightBarButtonItem = DeleteBarButton()
        navigationItem.rightBarButtonItem?.action = #selector(deleteButtonTapped)
        navigationItem.rightBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        imageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.bounds.width - 35)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Private
    
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func deleteButtonTapped() {
        output.deleteTapped()
    }
    
    @objc private func editButtonTapped() {
        output.editTapped()
    }
}

// MARK: - EditProductViewInput
extension EditProductViewController: EditProductViewInput {
}

// MARK: - UICollectionViewDataSource
extension EditProductViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ProductImageCell.self, for: indexPath)
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableFooter(EditProductInfoFooter.self, for: indexPath)
        footer.editButton.addTarget(self, for: #selector(editButtonTapped))
        output.configureFooter(footer, at: indexPath)
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let count = output.getImagesCount()
        imageControl.numberOfPages = count
        return count
    }
}

// MARK: - UICollectionViewDelegate
extension EditProductViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        imageControl.currentPage = collectionView.indexPathsForVisibleItems.first?.item ?? 0
    }
}
