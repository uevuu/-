//
//  SignUpService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 05.07.2023.
//

import Alamofire

// MARK: - SignUpService
final class SignUpService {
    private let signUpUrl = "http://77.105.136.70:8082/signUp"
    
    func signUp(
        with data: SignUpData,
        completion: @escaping (SignUpResult) -> Void
    ) {
        let params: Parameters = [
            "name": data.firstName,
            "surname": data.lastName,
            "email": data.email,
            "phone": data.phoneNumber,
            "password": data.password,
            "role": data.isSeller ? UserStatus.customer.rawValue : UserStatus.customer.rawValue
        ]
        AF.request(
            signUpUrl,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default
        )
        .validate()
        .responseDecodable { (response: DataResponse<UserInfo, AFError>) in
            switch response.result {
            case .success:
                return completion(.success)
            case .failure(let error):
                print(error.errorDescription?.lowercased())
                completion(.serviceError)
            }
        }
    }
}
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            if data.phoneNumber == "1234567" && data.email == "Admin@mail.ru" {
//                return completion(.sameEmailAndPhoneNumber)
//            } else if data.phoneNumber == "1234567" {
//                return completion(.samePhoneNumber)
//            } else if data.email == "Admin@mail.ru" {
//                return completion(.sameEmail)
//            } else {
//                return completion(.success)
//            }
//        }
