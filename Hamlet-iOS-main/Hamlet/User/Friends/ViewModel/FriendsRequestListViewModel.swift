//
//  FriendsRequestListViewModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class FriendsRequestListViewModel {
    var friendsRequestListResponse: FriendsRequestListModel? = nil
}

extension FriendsRequestListViewModel {
    func riendsRequestList(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        //let requestParam: [String: Any] = ["Search": ""]
        
        Webservice().request(url: RequestURL.FriendsRequestList.url, requestType: .get, params: [:]) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(FriendsRequestListResponse.self, from: data)  else {
                            completion(.failure(HTError.invalidResponse))
                                return
                            }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.friendsRequestListResponse = result
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
