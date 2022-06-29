//
//  SelectExpertisesViewModel.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class SelectExpertisesViewModel {
    var selectExpertisesResponse: SelectExpertisesResponse? = nil
}

extension SelectExpertisesViewModel {
    func requestSelectExpertises(with expertisesIDs: Array<Int>,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Array<Int>] = ["expertise_ids": expertisesIDs]
        
        Webservice().request(url: RequestURL.SelectExpertises.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(SelectExpertisesResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.selectExpertisesResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
