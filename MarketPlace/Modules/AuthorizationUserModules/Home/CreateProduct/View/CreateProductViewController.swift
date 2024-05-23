//
//  CreateProductViewController.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - CreateProductViewController
class CreateProductViewController: UIViewController {
    private let output: CreateProductViewOutput
    
    // MARK: - UI
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.register(AddProductImageCell.self)
        collectionView.register(DeleteProductImageCell.self)
        collectionView.registerFooter(CreateProductFooterView.self)
        collectionView.backgroundColor = R.color.background()
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let section: NSCollectionLayoutSection = {
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(115),
                    heightDimension: .absolute(128)
                ),
                subitems: [item]
            )
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(10)
                ),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            group.contentInsets.leading = 10
            group.contentInsets.trailing = 10
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [footer]
            section.contentInsets.top = 27
            section.contentInsets.bottom = 35
            section.orthogonalScrollingBehavior = .continuous
            return section
        }()
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
        
    // MARK: - Init
    
    init(output: CreateProductViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit Create Product View")
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
        setConstraints()
    }
    
    private func configureNavigationBar() {
        title = R.string.localizable.productСreation()
        navigationController?.navigationBar.titleTextAttributes = [
            .font: R.font.robotoRegular(size: 15) ?? UIFont()
        ]
        navigationItem.leftBarButtonItem = BackBarButton()
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
        navigationItem.leftBarButtonItem?.target = self
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // MARK: - Private
    @objc private func backButtonTapped() {
        output.backTapped()
    }
    
    @objc private func addPhotoButtonTapped() {
        print("add")
    }
    
    @objc private func deletePhotoButtonTapped(_ sender: DeleteProductImageCell) {
        let optionMenu = UIAlertController(
            title: nil,
            message: R.string.localizable.deleteProductPhotoWarning(),
            preferredStyle: .actionSheet
        )
        optionMenu.addDestructive(title: R.string.localizable.delete()) { [weak output] _ in
            output?.deletePhoto(at: sender.tag)
        }
        present(
            optionMenu,
            animated: true,
            completion: nil
        )
    }
    
    @objc private func nextButtonTapped() {
        output.nextTapped()
    }
}

// MARK: - ProductInfoViewInput
extension CreateProductViewController: CreateProductViewInput {
}

// MARK: - UICollectionViewDataSource
extension CreateProductViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(AddProductImageCell.self, for: indexPath)
            cell.addPhotoButton.addTarget(self, for: #selector(addPhotoButtonTapped))
            return cell
        }
        let cell = collectionView.dequeueReusableCell(DeleteProductImageCell.self, for: indexPath)
        cell.deleteButton.addTarget(self, for: #selector(deletePhotoButtonTapped(_:)))
        cell.deleteButton.tag = indexPath.item
        output.configureCell(cell, at: indexPath)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableFooter(CreateProductFooterView.self, for: indexPath)
        footer.nextButton.addTarget(self, for: #selector(nextButtonTapped))
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return output.getImagesCount()
    }
}
