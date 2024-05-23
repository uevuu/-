//
//  OrderInfoViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 10.07.2023.
//

import UIKit

// MARK: - OrderInfoViewInput
protocol OrderInfoViewInput: AnyObject {
}

// MARK: - OrderInfoViewOutput
protocol OrderInfoViewOutput: AnyObject {
    func getProductsCount() -> Int
    func configureCell(
        _ cell: UserOrderInfoTableViewCell,
        at indexPath: IndexPath
    )
    func configureHeader(_ header: OrderInfoPreViewHeader)
    func backTapped()
    func deinitEvent()
}
