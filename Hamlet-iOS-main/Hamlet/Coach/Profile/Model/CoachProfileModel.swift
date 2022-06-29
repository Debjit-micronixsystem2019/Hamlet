//
//  CoachProfileModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - CoachProfileResponse
struct CoachProfileResponse: Codable {
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
    let experties: [Experty]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case phone
        case phoneVerifiedAt = "phone_verified_at"
        case dob, gender, experties
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

// MARK: - Experty
struct Experty: Codable {
    let id, createdBy: Int?
    let name, expertyDescription: String?
    let image: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case expertyDescription = "description"
        case image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case pivot
    }
}

// MARK: - Pivot
struct Pivot: Codable {
    let userID, expertiseID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case expertiseID = "expertise_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
