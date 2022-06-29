//
//  AllFriendsListViewModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class AllFriendsListViewModel {
    var allFriendsListResponse: AllFriendsListModel? = nil
}

extension AllFriendsListViewModel {
    func requestAllFriendsList(currentPage : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = ["Search": ""]
        
        Webservice().request(url: RequestURL.AllFriendsList(page: currentPage).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(AllFriendsListResponse.self, from: data)  else {
                            completion(.failure(HTError.invalidResponse))
                                return
                            }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.allFriendsListResponse = result
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
