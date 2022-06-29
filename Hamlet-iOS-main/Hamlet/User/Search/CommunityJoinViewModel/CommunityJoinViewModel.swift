//
//  CommunityJoinViewModel.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class CommunityJoinViewModel {
    var communityJoinData: CommunityJoinResponce? = nil
}

extension CommunityJoinViewModel {
    func requestCommunityJoin(with id : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        
        Webservice().request(url: RequestURL.CommunityJoin(id: id).url, requestType: .put, params: [:]) { [weak self] (result) in
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
