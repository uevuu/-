//
//  SelectCategoryPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

// MARK: - SelectCategoryPresenter
final class SelectCategoryPresenter {
    weak var view: SelectCategoryViewInput?
    private var output: SelectCategoryPresenterOutput?
    
    init(
        output: SelectCategoryPresenterOutput?
    ) {
        self.output = output
    }
    
    deinit {
        print("deinit Select Category Presenter")
    }
}

// MARK: - SelectCategoryPresenter
extension SelectCategoryPresenter: SelectCategoryViewOutput {
    func getFilterCount() -> Int {
        return 10
    }
    
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
    }
    
    func selectCategory(at indexPath: IndexPath) {
        if indexPath.item == 3 {
            view?.enableButton()
        } else {
            view?.disableButton()
        }
    }
    
    func readyTapped() {
        output?.goToHomeModule()
    }
    
    func backTapped() {
        output?.goToPreviousModule()
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
