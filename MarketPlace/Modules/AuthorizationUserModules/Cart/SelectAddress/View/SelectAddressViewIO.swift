//
//  SelectAddressViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import UIKit

// MARK: - SelectAddressViewInput
protocol SelectAddressViewInput: AnyObject {
    func reloadData()
    func reloadCity(at indexPaths: [IndexPath])
}

// MARK: - SelectAddressViewOutput
protocol SelectAddressViewOutput: AnyObject {
    func getCityCount() -> Int
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    )
    func selectCity(at indexPath: IndexPath)
    func handleTextInput(_ text: String)
    func backTapped()
    func deinitEvent()
}
