//
//  TrainerBookingViewModel.swift
//  Hamlet
//
//  Created by admin on 11/17/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class TrainerBookingViewModel {
    var bookingResponse: BookingResponse? = nil
}

extension TrainerBookingViewModel {
    func requestTrainerBookingRequest(with id : Int, date: String,completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        let requestParam: [String: Any] = [
           "trainer_id": id,
           "booking_at": date
        ]
        Webservice().request(url: RequestURL.TrainerBooking.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(BookingResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }else{
                        self?.bookingResponse = json
                        completion(.success)
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
