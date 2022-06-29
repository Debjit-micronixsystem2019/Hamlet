//
//  TrainerBookingModel.swift
//  Hamlet
//
//  Created by admin on 11/17/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation


// MARK: - BookingResponse
struct BookingResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
   // let errors: [JSONAny]?
}
