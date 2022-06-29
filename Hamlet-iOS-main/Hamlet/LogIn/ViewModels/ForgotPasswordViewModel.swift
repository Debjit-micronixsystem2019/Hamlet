//
//  ForgotPasswordViewModel.swift
//  Hamlet
//
//  Created by admin on 12/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class ForgotPasswordViewModel {
    var forgotPasswordResponse: ForgotPasswordResponse? = nil
}

extension ForgotPasswordViewModel {
    func requestForgotPassword(email: String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = ["email": email]
        
        Webservice().request(url: RequestURL.ForgotPassword.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(ForgotPasswordResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        if json.errors?.email?[0] != nil{
                            completion(.failure(HTError.internalError(message: json.errors?.email?[0] ?? "")))
                            
                        }else{
                            completion(.failure(HTError.internalError(message: json.errorMessage ?? "")))
                        }
                        break
                       
                    }else{
                        self?.forgotPasswordResponse = json
                        completion(.success)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
