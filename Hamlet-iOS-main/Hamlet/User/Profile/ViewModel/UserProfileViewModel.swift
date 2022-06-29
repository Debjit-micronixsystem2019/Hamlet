//
//  UserProfileViewModel.swift
//  Hamlet
//
//  Created by admin on 11/5/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class ProfileViewModel {
    var profileResponse: ProfileResponse? = nil
}

extension ProfileViewModel {
    func requestProfileData(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.Profile.url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(ProfileResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                 //   if let result = json {
                        self?.profileResponse = json
                        completion(.success)
                   /* } else {
                        completion(.failure(HTError.noData))
                    }*/
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
