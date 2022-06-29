//
//  RatingViewModel.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class RatingViewModel {
    var ratingResponce: RatingResponceModel? = nil
}

extension RatingViewModel {
    func requestRating(with userID: Int, rating : Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "user_id": userID,
            "rating": rating
            ]
        
        Webservice().request(url: RequestURL.Rating.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(RatingResponceModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.ratingResponce = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
