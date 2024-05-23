//
//  ChooseCityViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - ChooseCityViewInput
protocol ChooseCityViewInput: AnyObject {
    func reloadData()
    func reloadCity(at indexPaths: [IndexPath])
}

// MARK: - ChooseCityViewOutput
protocol ChooseCityViewOutput: AnyObject {
    func getCityCount() -> Int
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    )
    func selectCity(at indexPath: IndexPath)
    func handleTextInput(_ text: String)
    func backTapped()
}
