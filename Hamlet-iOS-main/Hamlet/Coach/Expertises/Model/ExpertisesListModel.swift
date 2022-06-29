//
//  ExpertisesModel.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - ExpertisesListResponse
struct ExpertisesListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: ExpertisesListModel?
    let errors: [String]?
}

// MARK: - ExpertisesListModel
struct ExpertisesListModel: Codable {
    let data: [ExpertisesListData]?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

// MARK: - ExpertisesListData
struct ExpertisesListData: Codable {
    let id: Int?
    let name, datumDescription: String?
    let image: String?
    let createdAt, updatedAt: String?
    let usersCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case usersCount = "users_count"
    }
}

