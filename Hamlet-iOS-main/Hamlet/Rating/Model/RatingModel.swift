//
//  RatingModel.swift
//  Hamlet
//
//  Created by admin on 11/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
// MARK: - RatingResponceModel
struct RatingResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String
   // let errors: String?
}
