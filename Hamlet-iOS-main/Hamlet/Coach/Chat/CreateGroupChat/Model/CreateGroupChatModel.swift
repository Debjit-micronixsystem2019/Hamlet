//
//  CreateGroupChatModel.swift
//  Hamlet
//
//  Created by admin on 11/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
// MARK: - CreateGroupResponse
struct CreateGroupResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
   // let errors: [String]?
}
