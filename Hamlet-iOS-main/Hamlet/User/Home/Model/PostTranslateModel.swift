//
//  PostTranslateModel.swift
//  Hamlet
//
//  Created by admin on 6/24/22.
//  Copyright © 2022 Amit. All rights reserved.
//

import Foundation

// MARK: - PostTranslateResponce
struct PostTranslateResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
    //let errors: [JSONAny]?
}
