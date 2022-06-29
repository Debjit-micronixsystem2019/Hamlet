//
//  CommunityLeaveViewModel.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class CommunityLeaveViewModel {
    var communityLeaveData: CommunityLeaveResponce? = nil
}

extension CommunityLeaveViewModel {
    func requestCommunityLeave(with id : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        
        Webservice().request(url: RequestURL.CommunityLeave(id: id).url, requestType: .put, params: [:]) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CommunityLeaveResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.communityLeaveData = json
                        completion(.success)
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
