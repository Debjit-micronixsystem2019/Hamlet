//
//  RegistrationResponseModel.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct RegistrationResponseModel: Codable {
    let data: SignupResponse?
    let status: Int?
    let errorMessage: String?
    let errors: Errors?
}

struct Errors: Codable {
    let email: [String]?
    let phone: [String]?
    let name: [String]?
    let dob: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name, email, phone, dob
    }
}

struct SignupResponse: Codable {
    let name, email: String?
    let phone, userTypeID: Int?
    let dob, gender: String?
    let countryID, chatLanguageID: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case userTypeID = "user_type_id"
        case dob, gender
        case countryID = "country_id"
        case chatLanguageID = "chat_language_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
