//
//  ProfilePresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import UIKit
import Combine

// MARK: - ProfilePresenter
final class ProfilePresenter {
    weak var view: ProfileViewInput?
    private weak var output: ProfilePresenterOutput?
    private let userInfoService: UserInfoService
    private var userData: UserInfo?
    private let settings: [SettingType] = [
        .myOrder,
        .city,
        .theme
    ]
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        output: ProfilePresenterOutput?,
        userInfoService: UserInfoService
    ) {
        self.output = output
        self.userInfoService = userInfoService
    }
    
    deinit {
        print("deinit Profile presenter")
    }
}

// MARK: - ProfileViewOutput
extension ProfilePresenter: ProfileViewOutput {
    func viewDidLoadEvent() {
        userInfoService.userInfoPublisher
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] data in
                guard let self else { return }
                self.userData = data
                DispatchQueue.main.async {
                    self.view?.reloadInfo(
                        name: data.name,
                        email: data.email,
                        points: data.points
                    )
                }
            }
            .store(in: &cancellables)
        userInfoService.loadData()
    }
    
    func getSettingCount() -> Int {
        return settings.count
    }
    
    func configureCell(_ cell: SettingTableViewCell, at indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        switch setting {
        case .theme:
            cell.configureCell(title: R.string.localizable.applicationTheme())
        case .city:
            cell.configureCell(
                title: R.string.localizable.city(),
                helpData: userData?.city
            )
        case .myOrder:
            cell.configureCell(title: R.string.localizable.myOrder())
        }
    }
    
    func selectSetting(at indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        switch setting {
        case .theme:
            output?.goToAppColorTheme()
        case .city:
            output?.goToChooseCityModule()
        case .myOrder:
            output?.goToMyOrderModule()
        }
    }
    
    func profileTapped() {
        output?.goToUserInfoModule()
    }
    
    func cashInTapped() {
        output?.goToCashInModule()
    }
}
