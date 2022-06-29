//
//  SelectExpertisesModel.swift
//  Hamlet
//
//  Created by admin on 11/18/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - SelectExpertisesResponse
struct SelectExpertisesResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    let errors: [String]?
}
