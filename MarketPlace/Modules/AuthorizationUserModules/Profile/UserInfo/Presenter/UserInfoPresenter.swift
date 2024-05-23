//
//  UserInfoPresenter.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

import Combine
import Foundation

// MARK: - UserInfoPresenter
final class UserInfoPresenter {
    weak var view: UserInfoViewInput?
    private var output: UserInfoPresenterOutput?
    private let userInfoService: UserInfoService
    private var userData: UserInfo?
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        output: UserInfoPresenterOutput?,
        userInfoService: UserInfoService
    ) {
        self.output = output
        self.userInfoService = userInfoService
    }
    
    deinit {
        print("deinit User Info presenter")
    }
}

// MARK: - UserInfoViewOutput
extension UserInfoPresenter: UserInfoViewOutput {
    func viewDidLoadEvent() {
        userInfoService.userInfoPublisher
            .receive(on: DispatchQueue.global(qos: .userInteractive))
            .sink { [weak self] data in
                guard let self else { return }
                self.userData = data
                DispatchQueue.main.async {
                    self.view?.setData(data)
                }
            }
            .store(in: &cancellables)
        userInfoService.loadData()
    }
    
    func backTapped() {
        output?.goToUserInfoModule()
    }
    
    func logOutTapped() {
        output?.goToWelcomeModule()
    }
    
    func deleteAccountTapped() {
        output?.goToWelcomeModule()
    }
    
    func readyTapped(
        email: String,
        name: String,
        surname: String,
        patronymic: String?,
        gender: String?,
        birthDate: String?,
        phone: String
    ) {
        userInfoService.updateData(
            email: email,
            name: name,
            surname: surname,
            patronymic: patronymic,
            gender: gender,
            birthDate: birthDate,
            phone: phone
        )
    }
    
    func deinitEvent() {
        output?.moduleDidUnload()
    }
}
