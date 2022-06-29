//
//  CoachProfileViewModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

class CoachProfileViewModel {
    var profileResponse: CoachProfileResponse? = nil
}

extension CoachProfileViewModel {
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
                    guard let json = try? JSONDecoder().decode(CoachProfileResponse.self, from: data)  else {
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
