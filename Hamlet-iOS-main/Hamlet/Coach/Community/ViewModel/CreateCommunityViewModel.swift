//
//  CreateCommunityViewModel.swift
//  Hamlet
//
//  Created by admin on 6/22/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
class CreateCommunityViewModel {
    var createCommunityResponce: CreateCommunityResponceModel? = nil
}

extension CreateCommunityViewModel {
    func requestForCreateCommunity(with name: String, description: String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "name": name,
            "description": description
        ]
        
        Webservice().request(url: RequestURL.Communitie.url, requestType: .post, params: requestParam) { [weak self] (result) in
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
