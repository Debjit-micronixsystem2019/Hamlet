//
//  LogInVM.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

class LoginViewModel {
    var loginResponse: LoginResponse? = nil
}

extension LoginViewModel {
    func requestLogin(email: String, password: String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        let deviceToken = UserDefaults.standard.value(forKey: "deviceTokenString")
        
        let requestParam: [String: Any] = [
            "email": email,
            "password": password,
            "device_name": "ios",
            "device_token": deviceToken ?? "",
            "device_type": "ios"
        ]
        
        Webservice().request(url: RequestURL.login.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(LoginResponseModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.internalError(message: json.errorMessage ?? "")))
                        break
                    }
                    if let result = json.data {
                        self?.loginResponse = result
                        completion(.success)
                    } else {
                        completion(.failure(HTError.internalError(message: json.errorMessage ?? "")))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
