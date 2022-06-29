//
//  ChatModel.swift
//  Hamlet
//
//  Created by admin on 10/26/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - ChatMessageResponceModel
struct GetChatMessageResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: GetChatMessageDataModel?
    let errors: [String]?
}

// MARK: - DataClass
struct GetChatMessageDataModel: Codable {
    let data: [GetChatMessageData]?
    let currentPage: Int?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
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
struct GetChatMessageData: Codable {
    let id: Int?
    let message: String?
    let userID, chatID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let user: GetChatMessageUsers?

    enum CodingKeys: String, CodingKey {
        case id, message
        case userID = "user_id"
        case chatID = "chat_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case user
    }
}
// MARK: - User
struct GetChatMessageUsers: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifyToken, phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int
    let addedByID: String?
    let countryID, chatLanguageID: Int?

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
    }
}



// MARK: - PostChatMessageResponceModel
struct PostChatMessageResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: PostChatMessageData?
    let errors: [String]?
}

// MARK: - DataClass
struct PostChatMessageData: Codable {
    let message: String?
    let userID, chatID: Int?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case chatID = "chat_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

