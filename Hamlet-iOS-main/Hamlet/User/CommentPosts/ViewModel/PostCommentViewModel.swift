//
//  PostCommentViewModel.swift
//  Hamlet
//
//  Created by admin on 11/10/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class PostCommentViewModel {
    var postCommentResponce: PostCommentResponce? = nil
}

extension PostCommentViewModel {
    func requestToPostComment(with postid : Int, comment : String,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "post_id": postid,
            "comment": comment
        ]
        
        Webservice().request(url: RequestURL.PostInComment.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PostCommentResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else {
                        self?.postCommentResponce = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

