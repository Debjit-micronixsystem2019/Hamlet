//
//  FetchSelectedProblemModel.swift
//  Hamlet
//
//  Created by admin on 6/23/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - FetchSelectedProblemResponce
struct FetchSelectedProblemResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [FetchSelectedProblem]?
   // let errors: [JSONAny]?
}

// MARK: - Datum
struct FetchSelectedProblem: Codable {
    let id: Int?
    let name, datumDescription: String?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let pivot: SelectesProblemPivot?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case pivot
    }
}

// MARK: - Pivot
struct SelectesProblemPivot: Codable {
    let userID, problemID, active: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case problemID = "problem_id"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
