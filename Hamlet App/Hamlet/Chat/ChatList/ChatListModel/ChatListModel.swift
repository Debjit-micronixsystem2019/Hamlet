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
    let status: Int
    let errorMessage: String?
    let data: ChatListDataModel
    let errors: [String]
}

// MARK: - DataClass
struct ChatListDataModel: Codable {
    let currentPage: Int
    let data: [ChatListData]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

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
struct ChatListData: Codable {
    let id: Int
    let name: String
    let isClosed, createdBy, isPrivate, isGroup: Int
    let createdAt, updatedAt: String
    let isRequestAccepted: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case isClosed = "is_closed"
        case createdBy = "created_by"
        case isPrivate = "is_private"
        case isGroup = "is_group"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isRequestAccepted = "is_request_accepted"
    }
}

// MARK: - Link
struct ChatLink: Codable {
    let url: String?
    let label: String
    let active: Bool
}
