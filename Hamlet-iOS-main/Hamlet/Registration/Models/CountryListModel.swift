//
//  CountryListModel.swift
//  Hamlet
//
//  Created by admin on 11/29/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - CountryListResponse
struct CountryListResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: [CountryListData]?
   // let errors: [String]?
}

// MARK: - Datum
struct CountryListData: Codable {
    let id: Int?
    let name: String?
    let datumDescription: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case code
    }
}
