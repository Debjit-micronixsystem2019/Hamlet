//
//  NotificationModel.swift
//  Hamlet
//
//  Created by admin on 11/24/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - NotificationListResponse
struct NotificationListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [NotificationListData]?
 //   let errors: [String]?
}

// MARK: - Datum
struct NotificationListData: Codable {
    let id, userID, notificationableID: Int?
    let notificationableType, title, body: String?
    let readAt: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case notificationableID = "notificationable_id"
        case notificationableType = "notificationable_type"
        case title, body
        case readAt = "read_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
