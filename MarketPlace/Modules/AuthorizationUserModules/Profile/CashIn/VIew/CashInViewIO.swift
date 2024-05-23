//
//  CashInViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

// MARK: - CashInViewInput
protocol CashInViewInput: AnyObject {
}

// MARK: - CashInViewOutput
protocol CashInViewOutput: AnyObject {
    func cashIn(points: String)
    func deinitEvent()
}
