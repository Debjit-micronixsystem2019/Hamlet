//
//  DataObject.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import Alamofire

let devURL = "http://54.215.47.71/api"
let prodURL = "http://54.215.47.71/api"

let baseURL = devURL

enum RequestURL {
    case register
    case login
    case verifyEmail
    case ListCommunity
    case ChatList
    
    var url: URL? {
        switch self {
        case .register:
            let urlString = "\(baseURL)/register"
            return try? urlString.asURL()
        case .login:
            let urlString = "\(baseURL)/login"
            return try? urlString.asURL()
        case .verifyEmail:
            let urlString = "\(baseURL)/verify"
            return try? urlString.asURL()
        case .ListCommunity:
            let urlString = "\(baseURL)/communities"
            return try? urlString.asURL()
        case .ChatList:
            let urlString = "\(baseURL)/chats"
            return try? urlString.asURL()

        }
    }
}

enum RequestType {
    case get
    case post
}
