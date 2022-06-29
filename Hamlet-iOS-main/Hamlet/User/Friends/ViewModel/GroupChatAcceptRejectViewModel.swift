//
//  GroupChatAcceptRejectViewModel.swift
//  Hamlet
//
//  Created by admin on 11/24/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation


class GroupChatRequestAcceptRejectViewModel {
    var groupChatRequestAcceptRejectResponse: FriendRequestAcceptRejectResponse? = nil
}

extension GroupChatRequestAcceptRejectViewModel {
    func requestGroupChatRequestAcceptReject(with id : Int, accept : Bool,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [ "accept": accept]
        
        Webservice().request(url: RequestURL.GroupChatAcceptReject(id: id).url, requestType: .put, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(FriendRequestAcceptRejectResponse.self, from: data)  else {
                            completion(.failure(HTError.invalidResponse))
                                return
                            }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    } else {
                        self?.groupChatRequestAcceptRejectResponse = json
                        completion(.success)
                    }
                    case .failure(let error):
                        completion(.failure(error))
                        }
                    }
                }
            }
        }
