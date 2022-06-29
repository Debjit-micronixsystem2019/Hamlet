//
//  GetAllPostViewModel.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class CommunityWisePostListViewModel {
    var postListData: PostListModel? = nil

}

extension CommunityWisePostListViewModel {
    func requestPostListCommunityWise(with id : Int, currentPage : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "search":"",
            "community_id":id
        ]
        
        Webservice().request(url: RequestURL.ListPost(page: currentPage).url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PostListResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.postListData = result
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
