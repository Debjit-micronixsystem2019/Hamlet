//
//  SelectProblemViewModel.swift
//  Hamlet
//
//  Created by admin on 10/27/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
class SelectProblemListViewModel {
    var selectProblemResponse: SelectProblemListDataModel? = nil
}

extension SelectProblemListViewModel {
    func requestSelectProblemList(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [:]
        
        Webservice().request(url: RequestURL.SelectProblemList.url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(SelectProblemListResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                       // print("resultresult=>",result)
                        self?.selectProblemResponse = result
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
