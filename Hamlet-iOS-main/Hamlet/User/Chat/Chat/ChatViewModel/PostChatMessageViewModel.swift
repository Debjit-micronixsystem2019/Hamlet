//
//  PostChatMessageViewModel.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class PostChatMessageViewModel {
    var postChatMessageResponse: PostChatMessageData? = nil
}

extension PostChatMessageViewModel {
    func requestPostChatMessage(with id : String, message : String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = ["message": message]
        
        Webservice().request(url: RequestURL.PostChatMessage(id: id).url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PostChatMessageResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.postChatMessageResponse = result
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
