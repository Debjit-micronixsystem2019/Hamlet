//
//  BookingListModel.swift
//  Hamlet
//
//  Created by admin on 11/17/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - MyBookingListResponse
struct MyBookingListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: MyBookingListModel?
}

// MARK: - DataClass
struct MyBookingListModel: Codable {
    let data: [MyBookingListData]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - Datum
struct MyBookingListData: Codable {
    let id, userID, trainerID: Int?
    let bookingAt: String?
    let user: BookingUser?
    let trainer: BookingTrainer?
    let meetings: [BookigMeeting]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case trainerID = "trainer_id"
        case bookingAt = "booking_at"
        case user
        case trainer
        case meetings
    }
}

// MARK: - User
struct BookingUser: Codable {
    let id: Int?
    let name, email: String?
    let averageRating, image: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case averageRating = "average_rating"
        case image
    }
}

// MARK: - Meeting
struct BookigMeeting: Codable {
    let id, userID: Int?
    let title: String?
    let meetingDescription: String?
    let startURL, joinURL: String?
    let zoomID, zoomPassword, createdAt, updatedAt: String?
    let deletedAt: String?
    let bookingID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case meetingDescription = "description"
        case startURL = "start_url"
        case joinURL = "join_url"
        case zoomID = "zoom_id"
        case zoomPassword = "zoom_password"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case bookingID = "booking_id"
    }
}

// MARK: - Trainer
struct BookingTrainer: Codable {
    let id: Int?
    let name, email: String?
    let averageRating, image: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case averageRating = "average_rating"
        case image
    }
}

