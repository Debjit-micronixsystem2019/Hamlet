//
//  CreateCommunityModel.swift
//  Hamlet
//
//  Created by admin on 6/22/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - CreateCommunityResponce
struct CreateCommunityResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    //let errors: [JSONAny]?
}
