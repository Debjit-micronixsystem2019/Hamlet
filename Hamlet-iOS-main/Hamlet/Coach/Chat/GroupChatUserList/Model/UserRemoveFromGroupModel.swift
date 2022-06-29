//
//  UserRemoveFromGroupModel.swift
//  Hamlet
//
//  Created by admin on 12/8/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - UserRemoveFromGroupResponse
struct UserRemoveFromGroupResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    //let errors: [JSONAny]?
}
