//
//  ForgotPasswordModel.swift
//  Hamlet
//
//  Created by admin on 12/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - ForgotPasswordResponse
struct ForgotPasswordResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    let message: String?
    let errors: ForgotPasswordErrors?
}

// MARK: - Errors
struct ForgotPasswordErrors: Codable {
    let email: [String]?
}
