//
//  UserProfileResponseModel.swift
//  Hamlet
//
//  Created by admin on 11/5/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
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
    let averageRating: String?

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
    }
}
