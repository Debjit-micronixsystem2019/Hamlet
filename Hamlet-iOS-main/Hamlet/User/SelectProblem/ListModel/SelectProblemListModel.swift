//
//  SelectProblemModel.swift
//  Hamlet
//
//  Created by admin on 10/27/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - SelectProblemListResponceModel
struct SelectProblemListResponceModel: Codable {
    let status: Int?
    let errorMessage: String?
    let data: SelectProblemListDataModel?
    let errors: [String]
}

// MARK: - SelectProblemListDataModel
struct SelectProblemListDataModel: Codable {
  //  let currentPage: Int?
    let data: [SelectProblemListData]?
  //  let firstPageURL: String?
  //  let from, lastPage: Int?
  //  let path: String?
  //  let perPage: Int?
  //  let to, total: Int?

    enum CodingKeys: String, CodingKey {
     //   case currentPage = "current_page"
        case data
     //   case firstPageURL = "first_page_url"
     //   case from
     //   case lastPage = "last_page"
     //   case path
     //   case perPage = "per_page"
      //  case to, total
    }
}

// MARK: - SelectProblemListData
struct SelectProblemListData: Codable {
    let id: Int?
    let name, problemDescription: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case problemDescription = "description"
        case image
    }
}

