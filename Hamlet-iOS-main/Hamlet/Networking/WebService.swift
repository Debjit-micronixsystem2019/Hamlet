//
//  WebService.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import Alamofire

class Webservice: WebServiceProtocols {
    func request(url: URL?, requestType: RequestType, params: [String: Any]?, completion: @escaping (Result<Data, HTError>?) -> Void) {
        guard let url = url else {
            completion(.failure(HTError.unsuppotedURL))
            return
        }
        
        print("===========Parameters: ==========\n",params as Any)
        print("===========URL: ==========\n",url)

        let headers = Authentication().headers
        
        if requestType == .get {
            AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (responseData) in
                if let error = responseData.error {
                    print(error.localizedDescription)
                    completion(.failure(HTError.checkErrorCode(error.responseCode)))
                } else if let data = responseData.data {
                    
                  //  print("=============Token============\n",headers)
                    print("=============Response============\n",responseData.value as Any)
                    completion(.success(data))
                }
            }
        } else if requestType == .post {
            AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (responseData) in
                if let error = responseData.error {
                    print(error.localizedDescription)
                    completion(.failure(HTError.checkErrorCode(error.responseCode)))
                } else if let data = responseData.data {
                    print("=============Response============\n",responseData.value as Any)
                    completion(.success(data))
                }
            }
        } else if requestType == .put {
            AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (responseData) in
                if let error = responseData.error {
                    print(error.localizedDescription)
                    completion(.failure(HTError.checkErrorCode(error.responseCode)))
                } else if let data = responseData.data {
                    print("=============Response============\n",responseData.value as Any)
                    completion(.success(data))
                }
            }
        } else if requestType == .delete {
            AF.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).responseJSON { (responseData) in
                if let error = responseData.error {
                    print(error.localizedDescription)
                    completion(.failure(HTError.checkErrorCode(error.responseCode)))
                } else if let data = responseData.data {
                    print("=============Response============\n",responseData.value as Any)
                    completion(.success(data))
                }
            }
        }
    }
}
