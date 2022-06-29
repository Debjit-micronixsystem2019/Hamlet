//
//  SendFriendRequestViewModel.swift
//  Hamlet
//
//  Created by admin on 11/12/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class SendFriendRequestViewModel {
    var communityJoinData: CommunityJoinResponce? = nil
}

extension SendFriendRequestViewModel {
    func requestSendFriendRequest(with id : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        let requestParam: [String: Any] = [
           "friend_id": id
        ]
        Webservice().request(url: RequestURL.sendFriendRequest.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CommunityJoinResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.communityJoinData = json
                        completion(.success)
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
