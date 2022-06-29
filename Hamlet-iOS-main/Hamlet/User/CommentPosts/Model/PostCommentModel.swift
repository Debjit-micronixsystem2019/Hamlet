//
//  PostCommentModel.swift
//  Hamlet
//
//  Created by admin on 11/10/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

struct PostCommentResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
   // let errors: [String]?
}
