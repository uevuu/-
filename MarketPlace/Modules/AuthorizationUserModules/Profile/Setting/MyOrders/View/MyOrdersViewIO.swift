//
//  MyOrdersViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import UIKit

// MARK: - MyOrdersViewInput
protocol MyOrdersViewInput: AnyObject {
}

// MARK: - MyOrdersViewOutput
protocol MyOrdersViewOutput: AnyObject {
    func getOrdersCount() -> Int
    func configureCell(_ cell: OrderTableViewCell, at indexPath: IndexPath)
    func selectOrder(at indexPath: IndexPath)
    func backTapped()
    func deinitEvent()
}
