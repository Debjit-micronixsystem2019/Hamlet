//
//  BookingViewModel.swift
//  Hamlet
//
//  Created by admin on 11/17/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

class BookingListViewModel {
    var myBookingListResponse: MyBookingListModel? = nil
}

extension BookingListViewModel {
    func requestMyBookingList(completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        
        Webservice().request(url: RequestURL.TrainerBooking.url, requestType: .get, params: [:]) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(MyBookingListResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    
                    if let result = json.data {
                        self?.myBookingListResponse = result
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
    
    func requestZoomUrl(with title: String, userId : Int, bookigId: Int, completion: @escaping (HTResult) -> Void) {
        
        if !NetworkState().isConnected {
            completion(.failure(.internalError(message: Constants.noInternet)))
            return
        }
        let now = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDateString = df.string(from: now)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: now)
        let endDateString = df.string(from: endDate!)
        
        let requestParam: [String: Any] = [
            "title": title,
            "start_time": startDateString,
            "end_time": endDateString,
            "repeat": 0,
            "recurrence": "none",
            "duration": 30,
            "user_id": userId,
            "booking_id": bookigId
        ]
        
        Webservice().request(url: RequestURL.Meeting.url, requestType: .post, params: requestParam) { [weak self] (result) in
            if let result = result {
                switch result {
                case .success(let data):
                    guard let json = try? JSONDecoder().decode(MeetingResponse.self, from: data)  else {
                        completion(.failure(HTError.invalidResponse))
                        return
                    }
                    if let status = json.status, status != 200 {
                        print(status)
                        completion(.failure(HTError.noData))
                        break
                    }
                    if let result = json.data {
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
