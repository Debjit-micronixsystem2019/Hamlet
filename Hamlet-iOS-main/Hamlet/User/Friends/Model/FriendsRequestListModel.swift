//
//  FriendsRequestListModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - FriendsRequestListResponse
struct FriendsRequestListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: FriendsRequestListModel?
    let errors: [String]?
}

// MARK: - FriendsRequestListModel
struct FriendsRequestListModel: Codable {
    let currentPage: Int?
    let data: [FriendsRequestListData]?
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

// MARK: - FriendsRequestListData
struct FriendsRequestListData: Codable {
    let id, userID, isRequestAccepted: Int?
    let createdAt: String?
    let chatID: Int?
    let chatName: String?
    let senderID: Int?
    let senderName, senderEmail: String?
    let senderImage: String?
    let isPrivate: Int?
    let user: FriendsRequestUserDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case isRequestAccepted = "is_request_accepted"
        case createdAt = "created_at"
        case chatID = "chat_id"
        case chatName = "chat_name"
        case senderID = "sender_id"
        case senderName = "sender_name"
        case senderEmail = "sender_email"
        case senderImage = "sender_image"
        case user
        case isPrivate = "is_private"
    }
}

// MARK: - FriendsRequestUserDetails
struct FriendsRequestUserDetails: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int?
    let addedByID: String?
    let countryID, chatLanguageID: Int?
    let averageRating, image: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case phone
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
        case averageRating = "average_rating"
        case image
    }
}

