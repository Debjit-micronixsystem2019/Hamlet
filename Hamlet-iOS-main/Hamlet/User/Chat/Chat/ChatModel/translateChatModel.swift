//
//  translateChatModel.swift
//  Hamlet
//
//  Created by admin on 12/1/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation

// MARK: - TranslateChatMessageResponse
struct TranslateChatMessageResponse: Codable {
    let status: Int?
    let errorMessage: String?
    let data: String?
   // let errors: [JSONAny]?
}
