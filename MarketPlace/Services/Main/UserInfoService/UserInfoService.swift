//
//  UserInfoService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import Alamofire
import Combine

// MARK: - UserInfoService
protocol UserInfoService: AnyObject {
    func loadData()
    func addPoints(_ points: Int)
    func updateData(
        email: String,
        name: String,
        surname: String,
        patronymic: String?,
        gender: String?,
        birthDate: String?,
        phone: String
    )
    var userInfoPublisher: CurrentValueSubject<UserInfo, Never> { get }
}

// MARK: - UserInfoService
final class UserInfoServiceImp {
    private let networkService = NetworkService()
    
    func addPointCount(
        _ point: Int,
        completion: @escaping (Result<UserInfo, Error>) -> Void
    ) {
        networkService.sendPutRequest(
            endpoint: "/users",
            parameters: [
                "points": point
            ],
            completion: completion
        )
    }
    
    func getInfo(completion: @escaping (Result<UserInfo, Error>) -> Void) {
        if let userId = UserDefaults.standard.string(forKey: "id") {
            print(userId)
            networkService.sendGetRequest(
                endpoint: "/users/\(userId)",
                completion: completion
            )
        }
    }
}
