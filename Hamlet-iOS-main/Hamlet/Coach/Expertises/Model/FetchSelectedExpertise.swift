//
//  FetchSelectedExpertise.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - SelectedExpertiseResponce
struct SelectedExpertiseResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [SelectedExpertiseDataModel]?
   // let errors: [JSONAny]?
}

// MARK: - Datum
struct SelectedExpertiseDataModel: Codable {
    let id, createdBy: Int?
    let name, datumDescription: String?
    let image: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let pivot: ExpertisePivot?

    enum CodingKeys: String, CodingKey {
        case id
        case createdBy = "created_by"
        case name
        case datumDescription = "description"
        case image, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case pivot
    }
}

// MARK: - Pivot
struct ExpertisePivot: Codable {
    let userID, expertiseID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case expertiseID = "expertise_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
