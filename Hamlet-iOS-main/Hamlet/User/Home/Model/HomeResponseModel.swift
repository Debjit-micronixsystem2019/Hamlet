//
//  HomeResponseModel.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct CommunityListResponseModel: Codable {
    let status: Int?
    let data: CommunityListDetailsModel?
}

// MARK: - DataClass
struct CommunityListDetailsModel: Codable {
    let currentPage: Int?
    let data: [CommunityListData]?
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
struct CommunityListData: Codable {
    let id: Int?
    let createdBy: CreatedBy?
    let name, dataDescription: String?
    let image: String?
    let isPrivate, status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let postsCount, communityMembersCount: Int?
    let communityMembers: [CommunityListMember]?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case dataDescription = "description"
        case image
        case isPrivate = "is_private"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case postsCount = "posts_count"
        case communityMembersCount = "community_members_count"
        case communityMembers = "community_members"
    }
}

// MARK: - CommunityMember
struct CommunityListMember: Codable {
    let id, communityID, userID, isBan: Int?
    let isKicked: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case communityID = "community_id"
        case userID = "user_id"
        case isBan = "is_ban"
        case isKicked = "is_kicked"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int?
    let name, email, createdAt, updatedAt, deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

