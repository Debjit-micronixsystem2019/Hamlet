//
//  UserRemoveFromGroupViewModel.swift
//  Hamlet
//
//  Created by admin on 12/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
class UserRemoveFromGroupViewModel {
    var userRemoveFromGroupResponse: UserRemoveFromGroupResponse? = nil
}

extension UserRemoveFromGroupViewModel {
    func requestUserRemoveFromGroup(with groupid : Int, userID : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [:]
        
        Webservice().request(url: RequestURL.UserRemoveFromGroup(groupID: groupid, userID: userID).url, requestType: .put, params: requestParam) { [weak self] (result) in
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
