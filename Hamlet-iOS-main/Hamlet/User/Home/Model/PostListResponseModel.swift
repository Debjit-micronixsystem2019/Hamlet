//
//  PostListResponseModel.swift
//  Hamlet
//
//  Created by admin on 10/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - PostListResponceModel
struct PostListResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: PostListModel?
    let errors: [String]?
}

// MARK: - DataClass
struct PostListModel: Codable {
    let currentPage: Int?
    let data: [PostLstData]?
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
struct PostLstData: Codable {
    let id, communityID, userID: Int?
    let title, slug: String
    let body: String?
    let status: Int?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let commentsCount, likesCount: Int?
    let user: PostsUser?
    let comments: [PostsComment]?
    let likes: [PostsLike]?
    let community: PostsListCommunity?

    enum CodingKeys: String, CodingKey {
        case id
        case communityID = "community_id"
        case userID = "user_id"
        case title, slug, body, status, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case commentsCount = "comments_count"
        case likesCount = "likes_count"
        case user, comments, likes, community
    }
}

// MARK: - Comment
struct PostsComment: Codable {
    let id, userID: Int?
    let parentID: String?
    let comment: String?
    let commentableID: Int?
    let commentableType, createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case parentID = "parent_id"
        case comment
        case commentableID = "commentable_id"
        case commentableType = "commentable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Community
struct PostsListCommunity: Codable {
    let id, createdBy: Int?
    let name, communityDescription: String?
    let image: String?
    let isPrivate, status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case communityDescription = "description"
        case image
        case isPrivate = "is_private"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Like
struct PostsLike: Codable {
    let id, userID, like, likeableID: Int?
    let likeableType, createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case like
        case likeableID = "likeable_id"
        case likeableType = "likeable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - User
struct PostsUser: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifyToken, phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int?
    let addedByID: String?
    let countryID, chatLanguageID: Int
    let averageRating: String?

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
        case averageRating = "average_rating"
    }
}







/*// MARK: - AllTopicResponse
struct AllTopicResponse: Codable {
    let status: Int?
    let errorMessage: JSONNull?
    let data: DataClass?
    let errors: [JSONAny]?
}

// MARK: - DataClass
struct DataClass: Codable {
    let currentPage: Int?
    let data: [Datum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [Link]?
    let nextPageURL, path: String?
    let perPage: String?
    let prevPageURL: JSONNull?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id, communityID, userID: Int?
    let title, slug: String?
    let body: String?
    let status: Int?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?
    let commentsCount, likesCount: Int?
    let user: User?
    let comments: [Comment]?
    let likes: [Like]?
    let community: Community?

    enum CodingKeys: String, CodingKey {
        case id
        case communityID = "community_id"
        case userID = "user_id"
        case title, slug, body, status, image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case commentsCount = "comments_count"
        case likesCount = "likes_count"
        case user, comments, likes, community
    }
}

// MARK: - Comment
struct Comment: Codable {
    let id, userID: Int?
    let parentID: JSONNull?
    let comment: String?
    let commentableID: Int?
    let commentableType: AbleType?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case parentID = "parent_id"
        case comment
        case commentableID = "commentable_id"
        case commentableType = "commentable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

enum AbleType: String, Codable {
    case appModelsPost = "App\\Models\\Post"
}

// MARK: - Community
struct Community: Codable {
    let id, createdBy: Int?
    let name: Name?
    let communityDescription: String?
    let image: JSONNull?
    let isPrivate, status: Int?
    let createdAt: CreatedAt?
    let updatedAt: UpdatedAt?
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case communityDescription = "description"
        case image
        case isPrivate = "is_private"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

enum CreatedAt: String, Codable {
    case the20211021T142716000000Z = "2021-10-21T14:27:16.000000Z"
    case the20211231T025445000000Z = "2021-12-31T02:54:45.000000Z"
    case the20220210T071235000000Z = "2022-02-10T07:12:35.000000Z"
}

enum Name: String, Codable {
    case parenting101 = "Parenting 101"
    case perspective = "Perspective"
    case test1 = "Test 1"
}

enum UpdatedAt: String, Codable {
    case the20211122T155525000000Z = "2021-11-22T15:55:25.000000Z"
    case the20211231T025445000000Z = "2021-12-31T02:54:45.000000Z"
    case the20220210T071235000000Z = "2022-02-10T07:12:35.000000Z"
}

// MARK: - Like
struct Like: Codable {
    let id, userID, like, likeableID: Int?
    let likeableType: AbleType?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case like
        case likeableID = "likeable_id"
        case likeableType = "likeable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifiedAt: JSONNull?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?
    let userTypeID: Int?
    let addedByID: JSONNull?
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

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}
*/
