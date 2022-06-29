//
//  ProfileEditViewModel.swift
//  Hamlet
//
//  Created by admin on 5/24/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

class ProfileEditViewModel {
    var editProileResponce: EditProileResponceData? = nil
}

extension ProfileEditViewModel {
    func requestForProfileEditData(with id : Int, name : String, dob : String, gender : String, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: String] = [
            "name": name,
            "dob": dob,
            "gender": gender]
        
        Webservice().request(url: RequestURL.ProfileEdit(id: id).url, requestType: .put, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(EditProileResponce.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.internalError(message: json.errorMessage ?? "")))
                        break
                    }
                    if let result = json.data {
                        self?.editProileResponce = result
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
