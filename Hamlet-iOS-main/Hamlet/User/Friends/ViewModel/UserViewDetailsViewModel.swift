//
//  UserViewDetailsViewModel.swift
//  Hamlet
//
//  Created by admin on 11/16/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class UserViewDetailsViewModel {
    var userDetailsResponse: UserDetailsModel? = nil
}

extension UserViewDetailsViewModel {
    func requestUserViewDetails(with id : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [:]
        
        Webservice().request(url: RequestURL.UserViewDetails(id: id).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(UserDetailsResponse.self, from: data)  else {
                            completion(.failure(HTError.invalidResponse))
                                return
                            }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.userDetailsResponse = result
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
