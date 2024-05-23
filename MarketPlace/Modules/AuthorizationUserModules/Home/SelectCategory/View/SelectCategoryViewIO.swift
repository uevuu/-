//
//  SelectCategoryViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import UIKit

//  SelectCategoryViewInput
protocol SelectCategoryViewInput: AnyObject {
    func reloadCategory()
    func enableButton()
    func disableButton()
}

// MARK: - SelectCategoryViewOutput
protocol SelectCategoryViewOutput: AnyObject {
    func getFilterCount() -> Int
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath)
    func selectCategory(at indexPath: IndexPath)
    func readyTapped()
    func backTapped()
    func deinitEvent()
}
