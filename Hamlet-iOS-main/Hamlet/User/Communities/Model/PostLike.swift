//
//  PostLike.swift
//  Hamlet
//
//  Created by admin on 11/9/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

struct PostLikeResponce: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
   // let errors: [String]?
}


/*{
    "status": 200,
    "errorMessage": null,
    "data": "Like saved successfully!",
    "errors": []
}
 "like": 1
}*/
