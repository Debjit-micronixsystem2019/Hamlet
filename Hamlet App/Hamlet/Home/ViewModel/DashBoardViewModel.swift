//
//  DashBoardViewModel.swift
//  Hamlet
//
//  Created by admin on 10/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class DashBoardViewModel {
    var communityDetails: CommunityDetails? = nil
   // var paymentHistory: [PaymentDetails]? = nil
  //  var rentDetails: [RentDetails]? = nil
}

extension DashBoardViewModel {
    func requestCommunityDetails(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "search": ""
        ]
        
        Webservice().request(url: RequestURL.ListCommunity.url, requestType: .get, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(CommunityResponseModel.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.communityDetails = result
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
    
   /* func requestPaymentHistory(userId: Int, completion: @escaping (JMTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "actiontype": "payment_history",
            "user_id": 1//userId
        ]
        
        Webservice().request(url: RequestURL.baseUrl.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(PaymentHistory.self, from: data)  else {
                        completion(.failure(JMTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status == "no" {
                        print(status)
                        completion(.failure(JMTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.paymentHistory = result
                        completion(.success)
                    } else {
                        completion(.failure(JMTError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func requestRentList(userId: Int, completion: @escaping (JMTResult) -> Void) {
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }

        let requestParam: [String: Any] = [
            "actiontype": "rent_details",
            "user_id": 1//userId
        ]
        
        Webservice().request(url: RequestURL.baseUrl.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(RentModel.self, from: data)  else {
                        completion(.failure(JMTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status == "no" {
                        print(status)
                        completion(.failure(JMTError.noData))
                        break
                    }
                    if let result = json.data {
                        self?.rentDetails = result
                        completion(.success)
                    } else {
                        completion(.failure(JMTError.noData))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }*/
}
