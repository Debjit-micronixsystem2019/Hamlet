//
//  UserViewDetailsModel.swift
//  Hamlet
//
//  Created by admin on 11/16/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - UserDetailsResponse
struct UserDetailsResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: UserDetailsModel?
   // let errors: [String]?
}

// MARK: - DataClass
struct UserDetailsModel: Codable {
    let id: Int?
    let name, email, phone, dob: String?
    let gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let userTypeID, countryID, chatLanguageID: Int?
    let emailVerifiedAt: String?
    let averageRating, image: String?
    let userType: UserDetailsUserType?
    let country: UserDetailsCountry?
    let chatLanguage: UserDetailsChatLanguage?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, dob, gender
        case profilePicture = "profile_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userTypeID = "user_type_id"
        case countryID = "country_id"
        case chatLanguageID = "chat_language_id"
        case emailVerifiedAt = "email_verified_at"
        case averageRating = "average_rating"
        case image
        case userType = "user_type"
        case country
        case chatLanguage = "chat_language"
    }
}

// MARK: - ChatLanguage
struct UserDetailsChatLanguage: Codable {
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
struct UserDetailsCountry: Codable {
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

// MARK: - UserType
struct UserDetailsUserType: Codable {
    let id: Int?
    let name, userTypeDescription, createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userTypeDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
