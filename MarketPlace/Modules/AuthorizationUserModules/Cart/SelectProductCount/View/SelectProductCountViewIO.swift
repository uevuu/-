//
//  SelectProductCountViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 09.07.2023.
//

import UIKit

// MARK: - SelectProductCountViewInput
protocol SelectProductCountViewInput: AnyObject {
    func reloadCount(at indexPaths: [IndexPath])
    func setUncheck(at indexPath: IndexPath)
    func setCheck(at indexPath: IndexPath)
    func clearTextField()
}

// MARK: - SelectProductCountViewOutput
protocol SelectProductCountViewOutput: AnyObject {
    func getTableRowCount() -> Int
    func getRemainCount() -> Int
    func configureCell(
        _ cell: UITableViewCell,
        at indexPath: IndexPath
    )
    func selectCount(at indexPath: IndexPath)
    func readyTapped(with count: String)
    func handleTextInput(_ text: String)
    func deinitEvent()
}
