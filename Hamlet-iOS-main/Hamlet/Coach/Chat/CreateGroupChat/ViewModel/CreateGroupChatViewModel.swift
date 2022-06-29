//
//  CreateGroupChatViewModel.swift
//  Hamlet
//
//  Created by admin on 11/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class CreateGroupChatViewModel {
    var createGroupResponse: CreateGroupResponse? = nil
}

extension CreateGroupChatViewModel {
    func requestCreateGroup(with userIDs: Array<Int>,groupName : String,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "name": groupName,
            "invite_users": userIDs,
            "image": ""]
        
        Webservice().request(url: RequestURL.CreateGroup.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CreateGroupResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.createGroupResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
