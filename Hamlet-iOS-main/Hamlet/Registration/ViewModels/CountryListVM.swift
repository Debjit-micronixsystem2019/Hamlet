//
//  CountryListVM.swift
//  Hamlet
//
//  Created by admin on 11/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class CountryListViewModel {
    var countryListResponse: [CountryListData]? = nil
}

extension CountryListViewModel {
    func requestCountryList(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.CountryList.url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CountryListResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.countryListResponse = result
                        completion(.success)
                    } else {
                        completion(.failure(HTError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
