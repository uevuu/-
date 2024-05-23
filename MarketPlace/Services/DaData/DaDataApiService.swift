//
//  DaDataApiService.swift
//  MarketPlace
//
//  Created by Nikita Marin on 07.07.2023.
//

import Alamofire

// MARK: - DaDataApiService
final class DaDataApiService {
    private let networkService = DaDataNetworkApiService(
        baseUrl: R.string.daDataApi.baseUrl(),
        apiKey: R.string.daDataApi.secretKey()
    )
    
    func getPopulatedAreas(
        by query: String,
        completion: @escaping (Result<PopulatedAreas, Error>) -> Void
    ) {
        let parameters: [String: Any] = [
            R.string.daDataApi.query(): query,
            R.string.daDataApi.count(): 20,
            R.string.daDataApi.fromBound(): [R.string.daDataApi.value(): R.string.daDataApi.city()],
            R.string.daDataApi.toBound(): [R.string.daDataApi.value(): R.string.daDataApi.settlement()]
        ]
        networkService.sendRequest(
            endpoint: R.string.daDataApi.apiSuggestAddress(),
            parameters: parameters,
            completion: completion
        )
    }
    
    func getHouseAddress(
        by query: String,
        completion: @escaping (Result<PopulatedAreas, Error>) -> Void
    ) {
        let parameters: [String: Any] = [
            R.string.daDataApi.query(): query,
            R.string.daDataApi.count(): 20,
            R.string.daDataApi.fromBound(): [R.string.daDataApi.value(): R.string.daDataApi.city()],
            R.string.daDataApi.toBound(): [R.string.daDataApi.value(): R.string.daDataApi.house()]
        ]
        networkService.sendRequest(
            endpoint: R.string.daDataApi.apiSuggestAddress(),
            parameters: parameters,
            completion: completion
        )
    }
}
