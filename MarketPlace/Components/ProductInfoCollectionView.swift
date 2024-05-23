//
//  ProductInfoCollectionView.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

final class ProductInfoCollectionView: UICollectionView {
    lazy var imageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = R.color.secondary()
        pageControl.currentPageIndicatorTintColor = R.color.blue()
        return pageControl
    }()

    init() {
        super.init(
            frame: .zero,
            collectionViewLayout: {
                let section: NSCollectionLayoutSection = {
                    let item = NSCollectionLayoutItem(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .fractionalHeight(1)
                        )
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .fractionalWidth(1)
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
                    let section = NSCollectionLayoutSection(group: group)
                    section.boundarySupplementaryItems = [footer]
                    section.orthogonalScrollingBehavior = .groupPaging
                    return section
                }()
                
                let layout = UICollectionViewCompositionalLayout(section: section)
                return layout
            }()
        )
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = R.color.background()
    }
}
