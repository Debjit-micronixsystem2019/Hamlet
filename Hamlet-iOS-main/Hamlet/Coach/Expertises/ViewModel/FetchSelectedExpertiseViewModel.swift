//
//  FetchSelectedExpertiseViewModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
class FetchSelectedExpertisesListViewModel {
    var fetchExpertisesListResponse: [SelectedExpertiseDataModel]? = nil
}

extension FetchSelectedExpertisesListViewModel {
    func requestSelectedExpertisesList(with userid : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.FetchSelectedExpertise(userID: userid).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(SelectedExpertiseResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        //print("resultresult=>",result)
                        self?.fetchExpertisesListResponse = result
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
