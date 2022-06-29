//
//  PostOnCommunityViewModel.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class PostOnCommunityViewModel {
    var postOnCommunityData: PostOnCommunityResponce? = nil

}

extension PostOnCommunityViewModel {
    func requestPostOnCommunity(with id : Int,title : String, status: Int, postText : String,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "community_id": id,
            "title": title,
            "body": postText,
            "status": status,
            "image": "uploads/6/F8kQgnTLRQvaxbKtZnQ6Dpok7x3qtaeQIat7oE6K.txt",
        ]
        
        Webservice().request(url: RequestURL.postInCommunity.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PostOnCommunityResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else {
                        self?.postOnCommunityData = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
