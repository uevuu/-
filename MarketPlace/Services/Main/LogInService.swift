//
//  LogInService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import Alamofire

// MARK: - LogInService
final class LogInService {
    private let signInUrl = "http://77.105.136.70:8082/signIn"
    
    func login(
        emailOrPhoneNumber: String,
        password: String,
        completion: @escaping (LogInResult) -> Void
    ) {
        let params: Parameters = [
            "email": emailOrPhoneNumber,
            "phone": emailOrPhoneNumber,
            "password": password
        ]
        print(params)
        AF.request(
            signInUrl,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable { (response: DataResponse<UserInfo, AFError>) in
            switch response.result {
            case .success:
                return completion(.success)
            case .failure:
                completion(.serviceError)
            }
        }
    }
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//        if ["Adm@ma.ru", "Nikita@qq.q", "1234567"].contains(where: { $0 == emailOrPhoneNumber }) {
//            if password == "123" {
//                return completion(.success)
//            } else {
//                return completion(.incorrectPassword)
//            }
//        } else {
//            return completion(.userExist)
//        }
//    }
}
