//
//  ParticipantsUserCommunityModel.swift
//  Hamlet
//
//  Created by admin on 6/28/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - ParticipantUserInCommunityResponce
struct ParticipantUserInCommunityResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [ParticipantUserInCommunityDataModel]?
  //  let errors: [JSONAny]?
}

// MARK: - ParticipantUserInCommunityDataModel
struct ParticipantUserInCommunityDataModel: Codable {
    let id, communityID, userID, isBan: Int?
    let isKicked: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let user: ParticipantUserInCommunityUserData?

    enum CodingKeys: String, CodingKey {
        case id
        case communityID = "community_id"
        case userID = "user_id"
        case isBan = "is_ban"
        case isKicked = "is_kicked"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case user
    }
}

// MARK: - ParticipantUserInCommunityUserData
struct ParticipantUserInCommunityUserData: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int?
    let addedByID: String?
    let countryID, chatLanguageID, isActive: Int?
    let averageRating: String?
    let image: String?

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
        case isActive = "is_active"
        case averageRating = "average_rating"
        case image
    }
}