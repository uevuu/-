//
//  NetworkService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 12.07.2023.
//

import Alamofire

enum NetworkError: Error {
    case unauthorized
}

// MARK: - NetworkService
final class NetworkService {
    private let baseURL = "http://77.105.136.70:8082"
    
    func sendGetRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NetworkError.unauthorized))
            return
        }
        AF.request(
            baseURL + endpoint,
            method: .get,
            parameters: parameters,
            headers: HTTPHeaders(["Authorization": token])
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendPostRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NetworkError.unauthorized))
            return
        }
        AF.request(
            baseURL + endpoint,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(["Authorization": token])
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendPutRequest<T: Codable>(
        endpoint: String,
        parameters: Parameters = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else {
            completion(.failure(NetworkError.unauthorized))
            return
        }
        AF.request(
            baseURL + endpoint,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(["Authorization": token])
        )
        .validate()
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
