//
//  FilterPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - FilterPresenter
final class FilterPresenter {
    weak var view: FilterViewInput?
    private var output: FilterPresenterOutput?
    private let categoryService: CategoryService
    private var categories: [Category] = []
    private var selectedCategory = 0
    private var selectedParentId: Int?
    
    init(
        output: FilterPresenterOutput?,
        categoryService: CategoryService
    ) {
        self.output = output
        self.categoryService = categoryService
    }
    
    deinit {
        print("deinit Filter Presenter")
    }
}

// MARK: - FilterViewOutput
extension FilterPresenter: FilterViewOutput {
    func viewDidLoadEvent() {
        categoryService.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                DispatchQueue.main.async {
                    self?.view?.reloadFilter()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    func getFilterCount() -> Int {
        return categories.filter { $0.parentId == selectedParentId } .count + 1
    }
    
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        if indexPath.item == 0 {
            if selectedCategory == 0 {
                let imageView = UIImageView(image: UIImage(systemName: R.string.systemImage.checkmarkCircleFill()))
                cell.accessoryView = imageView
            } else {
                let imageView = UIImageView(image: UIImage(systemName: R.string.systemImage.circle()))
                cell.accessoryView = imageView
            }
            cell.textLabel?.text = R.string.localizable.allCategory()
        } else {
            if selectedCategory == indexPath.item {
                let imageView = UIImageView(image: UIImage(systemName: R.string.systemImage.checkmarkCircleFill()))
                cell.accessoryView = imageView
            } else {
                let imageView = UIImageView(image: UIImage(systemName: R.string.systemImage.circle()))
                cell.accessoryView = imageView
            }
            cell.textLabel?.text = categories.filter { $0.parentId == selectedParentId }[indexPath.item - 1].title
        }
    }
    
    func selectCategory(at indexPath: IndexPath) {
        selectedCategory = indexPath.item
        view?.reloadFilter()
    }
    
    func handleMinPriceInput(_ text: String) {
        print(text)
    }
    
    func handleMaxPriceInput(_ text: String) {
        print(text)
    }
    
    func applyTapped() {
        output?.goToHomeModule()
    }
    
    func backTapped() {
        output?.goToHomeModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
