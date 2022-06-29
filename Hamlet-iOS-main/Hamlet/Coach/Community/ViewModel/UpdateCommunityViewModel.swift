//
//  UpdateCommunityViewModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
class UpdateCommunityViewModel {
    var createCommunityResponce: CreateCommunityResponceModel? = nil
}

extension UpdateCommunityViewModel {
    func requestForUpdateCommunity(with name: String, description: String, communityID: Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "name": name,
            "description": description
        ]
        
        Webservice().request(url: RequestURL.UpdateCommunity(communityID: communityID).url, requestType: .put, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CreateCommunityResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.createCommunityResponce = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
