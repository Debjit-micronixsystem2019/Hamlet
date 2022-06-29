//
//  LoginResponseModel.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct LoginResponseModel: Decodable {
    let data: LoginResponse?
    let status: Int?
    let errorMessage: String?
//    let errors: [String]?
}

struct LoginResponse: Decodable {
    let token: String?
    let user: User?
    let emailVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case token, user
        case emailVerified = "email_verified"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let phone: String?
    let phoneVerifyToken, phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int?
    let addedByID: String?
    let countryID, chatLanguageID: Int?
    let userType: ChatLanguage?
    let country: Country?
    let chatLanguage: ChatLanguage?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case phone
        case phoneVerifyToken = "phone_verify_token"
        case phoneVerifiedAt = "phone_verified_at"
        case dob, gender
        case profilePicture = "profile_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case userTypeID = "user_type_id"
        case addedByID = "added_by_id"
        case countryID = "country_id"
        case chatLanguageID = "chat_language_id"
        case userType = "user_type"
        case country
        case chatLanguage = "chat_language"
    }
}

// MARK: - ChatLanguage
struct ChatLanguage: Codable {
    let id: Int?
    let name, flag, code, chatLanguageDescription: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, flag, code
        case chatLanguageDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Country
struct Country: Codable {
    let id: Int?
    let code, isoCode, langCode, name: String?
    let flag, isd: String?
    let countryDescription: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, code
        case isoCode = "iso_code"
        case langCode = "lang_code"
        case name, flag, isd
        case countryDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
