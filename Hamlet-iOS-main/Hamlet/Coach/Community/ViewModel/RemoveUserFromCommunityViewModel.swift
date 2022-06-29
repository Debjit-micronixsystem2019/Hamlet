//
//  RemoveUserFromCommunityViewModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

class UserRemoveFromCommunityViewModel {
    var userRemoveFromGroupResponse: UserRemoveFromGroupResponse? = nil
}

extension UserRemoveFromCommunityViewModel {
    func requestUserRemoveFromCommunity(with communityid : Int, userID : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [:]
        
        Webservice().request(url: RequestURL.RemoveUserFromCommunity(communityID: communityid, UserID: userID).url, requestType: .put, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(UserRemoveFromGroupResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.userRemoveFromGroupResponse = json
                        completion(.success)
                }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
