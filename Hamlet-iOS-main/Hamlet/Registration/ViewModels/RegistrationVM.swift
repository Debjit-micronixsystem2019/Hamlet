//
//  RegistrationVM.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

class RegistrationViewModel {
    
    var signupResponse: SignupResponse? = nil
    let requestBody: SignupRequestModel
    
    init(requestBody: SignupRequestModel) {
        self.requestBody = requestBody
    }
}

extension RegistrationViewModel {
    func requestSignup(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "user_type_id": requestBody.userType,
            "name": requestBody.name,
            "email": requestBody.email,
            "password": requestBody.password,
            "dob": requestBody.dob,
            "gender": requestBody.gender,
            "phone": requestBody.phone,
            "country_id": requestBody.countryId,
            "chat_language_id":requestBody.chatLanguageId,
            "profile_picture": requestBody.profilePicture,
        ]
        
        print("requestParam: ", requestParam)
        Webservice().request(url: RequestURL.register.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    
                    guard let json = try? JSONDecoder().decode(RegistrationResponseModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        
                        if json.errors?.email?[0] != nil{
                            completion(.failure(HTError.internalError(message: json.errors?.email?[0] ?? "")))
                            
                        }else if json.errors?.name?[0] != nil{
                            completion(.failure(HTError.internalError(message: json.errors?.name?[0] ?? "")))
                            
                        }else if json.errors?.dob?[0] != nil{
                            completion(.failure(HTError.internalError(message: json.errors?.dob?[0] ?? "")))
                            
                        }else if json.errors?.phone?[0] != nil{
                            completion(.failure(HTError.internalError(message: json.errors?.phone?[0] ?? "")))
                            
                        }else{
                            completion(.failure(HTError.internalError(message: "The server is not responding currently, Please try agian.")))
                        }
                        break
                    }
                    if let result = json.data {
                        self?.signupResponse = result
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
