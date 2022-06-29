//
//  TrainerViewModel.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class TrainerCommunityListViewModel {
    var TrainerCommunityListData: TrainerCommunityList? = nil
}

extension TrainerCommunityListViewModel {
    func requestTrainerCommunityList(with id : Int, searchData : String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [:]
        
        Webservice().request(url: RequestURL.TrainerCommunityList(search: searchData, id: id).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(TrainerCommunityListResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.TrainerCommunityListData = result
                        completion(.success)
                    } else {
                        completion(.failure(HTError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
