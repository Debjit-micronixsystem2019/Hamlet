//
//  EmailVerifyModel.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - EmailVerifyResponceModel
struct EmailVerifyResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data, message: String
    let errors: String?
}
