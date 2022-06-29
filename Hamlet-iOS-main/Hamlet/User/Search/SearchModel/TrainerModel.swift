//
//  TrainerModel.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - TrainerCommunityListResponceModel
struct TrainerCommunityListResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: TrainerCommunityList?
    let errors: [String]?
}

// MARK: - DataClass
struct TrainerCommunityList: Codable {
    let trainers: [TrainerList]?
    let communities: [CommunityList]?
}

// MARK: - Community
struct CommunityList: Codable {
    let id, membercount: Int?
    let name, communityDescription: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case communityDescription = "description"
        case membercount = "member_count"
        case image
    }
}

// MARK: - Trainer
struct TrainerList: Codable {
    let id, isfriend : Int?
    let name: String?
    let profilePicture, averageRating: String?
    let experties: [TagExpertiseDataModel]?
    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePicture = "profile_picture"
        case averageRating = "average_rating"
        case isfriend = "is_friend"
        case experties
    }
}

struct TagExpertiseDataModel: Codable {
    let id, createdBy: Int?
    let name, datumDescription: String?
    let image: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let pivot: TagExpertisePivot?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case datumDescription = "description"
        case image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case pivot
    }
}

// MARK: - Pivot
struct TagExpertisePivot: Codable {
    let userID, expertiseID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case expertiseID = "expertise_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
