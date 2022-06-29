//
//  AllUserListVIewModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class AllUserListViewModel {
    var allUserListResponse: AllUserListModel? = nil
}

extension AllUserListViewModel {
    func requestAllUserList(with id : Int, currentpage : Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        
        //  1=Trainer
        //  2=Normal Users
        // 0 = All
        
        let requestParam: [String: Any] = ["search":"",
                                           "user_type_id":id]
        
        Webservice().request(url: RequestURL.AllUserList(page: currentpage).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(AllUserListResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.allUserListResponse = result
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
