//
//  PostTranslateViewModel.swift
//  Hamlet
//
//  Created by admin on 6/24/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

class PostTranslateViewModel {
    var postTranslateResponce: PostTranslateResponce? = nil
}

extension PostTranslateViewModel {
    func requestForPostTranslate(with languageID: Int, postID: Int,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        
        Webservice().request(url: RequestURL.PostTranslate(postID: postID, languageID: languageID).url, requestType: .get, params: [:]) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PostTranslateResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.postTranslateResponce = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
