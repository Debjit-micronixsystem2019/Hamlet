//
//  AllFriendsListModel.swift
//  Hamlet
//
//  Created by admin on 11/15/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - AllFriendsListResponse
struct AllFriendsListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: AllFriendsListModel?
    let errors: [String]?
}

// MARK: - AllFriendsListModel
struct AllFriendsListModel: Codable {
    let data: [AllFriendsListData]?
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

// MARK: - AllFriendsListData
struct AllFriendsListData: Codable {
    let id: Int?
    let name, email, phone, dob: String?
    let gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let userTypeID, countryID, chatLanguageID, chatID: Int?
    let participantID, isRequestAccepted: Int?
    let averagerating: String?


    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, dob, gender
        case profilePicture = "profile_picture"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userTypeID = "user_type_id"
        case countryID = "country_id"
        case chatLanguageID = "chat_language_id"
        case chatID = "chat_id"
        case participantID = "participant_id"
        case isRequestAccepted = "is_request_accepted"
        case averagerating = "average_rating"
    }
}
