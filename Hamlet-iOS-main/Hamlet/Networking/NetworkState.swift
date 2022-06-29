//
//  NetworkState.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkState {
    var isConnected: Bool {
        return NetworkReachabilityManager(host: "www.apple.com")!.isReachable
    }
}
