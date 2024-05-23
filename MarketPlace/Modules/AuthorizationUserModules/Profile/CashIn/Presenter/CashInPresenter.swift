//
//  CashInPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

// MARK: - CashInPresenter
final class CashInPresenter {
    weak var view: CashInViewInput?
    private var output: CashInPresenterOutput?
    private let userInfoService: UserInfoService
    
    init(
        output: CashInPresenterOutput?,
        userInfoService: UserInfoService
    ) {
        self.output = output
        self.userInfoService = userInfoService
    }
    
    deinit {
        print("deinit Cash In presenter")
    }
}

// MARK: - CashInViewOutput
extension CashInPresenter: CashInViewOutput {
    func cashIn(points: String) {
        if let intPoints = Int(points) {
            userInfoService.addPoints(intPoints)
        }
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
