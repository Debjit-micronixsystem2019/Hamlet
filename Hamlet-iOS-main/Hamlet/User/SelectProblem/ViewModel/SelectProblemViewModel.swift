//
//  SelectProblemViewModel.swift
//  Hamlet
//
//  Created by admin on 10/27/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
class SelectProblemViewModel {
    var selectProblemResponse: SelectProblemResponceModel? = nil
}

extension SelectProblemViewModel {
    func requestSelectProblem(with problemIDs: Array<Int>,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Array<Int>] = ["problem_ids": problemIDs]
        
        Webservice().request(url: RequestURL.SelectProblem.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(SelectProblemResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.selectProblemResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
