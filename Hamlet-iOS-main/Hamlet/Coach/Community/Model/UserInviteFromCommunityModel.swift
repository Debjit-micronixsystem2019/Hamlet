//
//  UserInviteFromCommunityModel.swift
//  Hamlet
//
//  Created by admin on 6/22/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation
// MARK: - AddUserCommunityResponceModel
struct AddUserCommunityResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    //let errors: [JSONAny]?
}
