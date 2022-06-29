//
//  Authentication.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import Alamofire

class Authentication {
    var headers: HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if let authToken = authToken {
            headers["Authorization"] = authToken
        }
        return headers
    }
    
    var authToken: String? {
        return UserDefaults.standard.string(forKey: Defaults.authKey)
    }
    
    func saveToken(token: String) {
        let authToken = "Bearer \(token)"
        UserDefaults.standard.setValue(authToken, forKey: Defaults.authKey)
    }
}

//23|8wvUpYJzSRNzT3lim4GdJeFiFvLO4V1wh1qzk0rE
