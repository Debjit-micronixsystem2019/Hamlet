//
//  CoachCommunityListViewModel.swift
//  Hamlet
//
//  Created by admin on 6/22/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
class AddUserCommunityViewModel {
    var addUserCommunityResponce: AddUserCommunityResponceModel? = nil
}

extension AddUserCommunityViewModel {
    func requestForAddUserInCommunity(with addUserID: Array<Int>, communityID: Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "user_ids": addUserID
        ]
        
        Webservice().request(url: RequestURL.CommunityAddUser(communityID: communityID).url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(AddUserCommunityResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.addUserCommunityResponce = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
