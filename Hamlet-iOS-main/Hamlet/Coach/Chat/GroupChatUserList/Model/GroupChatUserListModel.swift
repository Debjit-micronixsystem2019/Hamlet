//
//  GroupChatUserListModel.swift
//  Hamlet
//
//  Created by admin on 12/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation


// MARK: - GroupChatUserListResponse
struct GroupChatUserListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: GroupChatUserListModel?
   // let errors: [JSONAny]?
}

// MARK: - DataClass
struct GroupChatUserListModel: Codable {
    let data: [GroupChatUserListData]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct GroupChatUserListData: Codable {
    let id: Int?
    let name, email, phone, dob: String?
    let gender: String?
    let profilePicture: String?
    let createdAt, updatedAt: String?
    let userTypeID, countryID, chatLanguageID, chatID: Int?
    let participantID, isRequestAccepted: Int?
    let averageRating: String?
    let image: String?

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
        case averageRating = "average_rating"
        case image
    }
}
