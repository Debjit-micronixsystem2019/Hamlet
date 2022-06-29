//
//  ChatListModel.swift
//  Hamlet
//
//  Created by admin on 10/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - ChatList
struct ChatListResponseModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: ChatListDataModel?
    let errors: [String]?
}

// MARK: - DataClass
struct ChatListDataModel: Codable {
    let currentPage: Int?
    let data: [ChatListData]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
   // let perPage: Int?
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
      //  case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct ChatListData: Codable {
    let id: Int?
    let name,image: String?
    let isClosed, createdBy, isPrivate, isGroup: Int?
    let createdAt, updatedAt: String?
    let isRequestAccepted: Int?
    let latestMessage: LatestMessage?

    enum CodingKeys: String, CodingKey {
        case id, name,image
        case isClosed = "is_closed"
        case createdBy = "created_by"
        case isPrivate = "is_private"
        case isGroup = "is_group"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isRequestAccepted = "is_request_accepted"
        case latestMessage = "latest_message"
    }
}

// MARK: - LatestMessage
struct LatestMessage: Codable {
    let id: Int?
    let message: String?
    let userID, chatID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let seen: Bool?
    let translatedText: String?
    let sender: Sender?

    enum CodingKeys: String, CodingKey {
        case id, message
        case userID = "user_id"
        case chatID = "chat_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case seen
        case translatedText = "translated_text"
        case sender
    }
}

// MARK: - Sender
struct Sender: Codable {
    let id: Int?
    let name, email: String?
    let profilePicture: String?
    let averageRating: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case profilePicture = "profile_picture"
        case averageRating = "average_rating"
        case image
    }
}








/* MARK: - Chatlist
struct Chatlist: Codable {
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
    let id: Int?
    let name: String?
    let isClosed, createdBy, isPrivate: Int?
    let image: JSONNull?
    let isGroup: Int?
    let createdAt, updatedAt: String?
    let isRequestAccepted: Int?
    let mCreatedAt: String?
    let latestMessage: LatestMessage?

    enum CodingKeys: String, CodingKey {
        case id, name
        case isClosed = "is_closed"
        case createdBy = "created_by"
        case isPrivate = "is_private"
        case image
        case isGroup = "is_group"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isRequestAccepted = "is_request_accepted"
        case mCreatedAt = "m_created_at"
        case latestMessage = "latest_message"
    }
}

// MARK: - LatestMessage
struct LatestMessage: Codable {
    let id: Int?
    let message: String?
    let userID, chatID: Int?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?
    let seen: Bool?
    let translatedText: String?
    let sender: Sender?

    enum CodingKeys: String, CodingKey {
        case id, message
        case userID = "user_id"
        case chatID = "chat_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case seen
        case translatedText = "translated_text"
        case sender
    }
}

// MARK: - Sender
struct Sender: Codable {
    let id: Int?
    let name, email: String?
    let profilePicture: String?
    let averageRating: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case profilePicture = "profile_picture"
        case averageRating = "average_rating"
        case image
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}*/
