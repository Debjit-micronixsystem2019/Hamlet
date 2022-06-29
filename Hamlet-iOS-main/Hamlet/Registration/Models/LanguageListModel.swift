//
//  LanguageListModel.swift
//  Hamlet
//
//  Created by admin on 11/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - LanguageListResponse
struct LanguageListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [LanguageListData]?
 //   let errors: [JSONAny]?
}

// MARK: - Datum
struct LanguageListData: Codable {
    let id: Int?
    let name, datumDescription, code: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case code
    }
}
