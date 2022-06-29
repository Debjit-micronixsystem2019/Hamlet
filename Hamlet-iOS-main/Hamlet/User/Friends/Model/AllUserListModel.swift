//
//  AllUserListModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - AllUserListResponse
struct AllUserListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: AllUserListModel?
    let errors: [String]?
}

// MARK: - DataClass
struct AllUserListModel: Codable {
    let data: [AllUserListData]?
    let currentPage: Int?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL, path: String?
    let perPage: String?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct AllUserListData: Codable {
    var id, isfriend: Int?
    var name, email, phone, dob: String?
    var gender: String?
    var profilePicture: String?
    var createdAt, updatedAt: String?
    var userTypeID, countryID, chatLanguageID: Int?
    var emailVerifiedAt: String?
    var averageRating, image: String?
    var userType: UserType?
    var country: UsersCountry?
    var chatLanguage: UsersChatLanguage?

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
        case isfriend = "is_friend"
    }
}

// MARK: - UserType
struct UserType: Codable {
    var id: Int?
    var name, userTypeDescription, createdAt, updatedAt: String?
    var deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case userTypeDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - ChatLanguage
struct UsersChatLanguage: Codable {
    var id: Int?
    var name, flag, code, chatLanguageDescription: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, flag, code
        case chatLanguageDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Country
struct UsersCountry: Codable {
    var id: Int?
    var code, isoCode, langCode, name: String?
    var flag, isd: String?
    var countryDescription: String?
    var createdAt, updatedAt: String?
    var deletedAt: String?

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

// MARK: - MeetingResponse
struct MeetingResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    let errors: [String]?
}
