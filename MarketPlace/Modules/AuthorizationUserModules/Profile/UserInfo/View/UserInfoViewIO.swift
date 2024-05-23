//
//  UserInfoViewIO.swift
//  MarketPlace
//
//  Created by Nikita Marin on 06.07.2023.
//

// MARK: - UserInfoViewInput
protocol UserInfoViewInput: AnyObject {
    func hideReadyButton()
    func setData(_ userInfo: UserInfo)
}

// MARK: - UserInfoViewOutput
protocol UserInfoViewOutput: AnyObject {
    func viewDidLoadEvent()
    func backTapped()
    func logOutTapped()
    func deleteAccountTapped()
    func readyTapped(
        email: String,
        name: String,
        surname: String,
        patronymic: String?,
        gender: String?,
        birthDate: String?,
        phone: String
    )
    func deinitEvent()
}
