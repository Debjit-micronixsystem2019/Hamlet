
//  Model.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - CommentListResponse
struct CommentListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: CommentListDataModel?
    //let errors: [JSONAny]?
}

// MARK: - DataClass
struct CommentListDataModel: Codable {
    let data: [CommentListData]?
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
struct CommentListData: Codable {
    let id, userID: Int?
  //  let parentID: CommentListData?
    let comment: String?
    let commentableID: Int?
    let commentableType, createdAt, updatedAt: String?
   // let deletedAt: CommentListData?
    let user: UserWiseComment?
    let replies: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
       // case parentID = "parent_id"
        case comment
        case commentableID = "commentable_id"
        case commentableType = "commentable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
       // case deletedAt = "deleted_at"
        case user, replies
    }
}

// MARK: - User
struct UserWiseComment: Codable {
    let id: Int?
    let name, email, emailVerifiedAt, phone: String?
    let phoneVerifyToken, phoneVerifiedAt: String?
    let dob, gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userTypeID: Int?
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
