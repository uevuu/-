//
//  UserInfo.swift
//  MarketPlace
//
//  Created by Nikita Marin on 11.07.2023.
//

import Foundation

struct UserInfo: Codable {
    let id: String
    let role: String
    var email: String
    var name: String
    var surname: String
    var patronymic: String?
    var gender: String?
    var birthDate: String?
    var phone: String
    var profilePicture: String?
    var points: Int
    var city: String?
}
