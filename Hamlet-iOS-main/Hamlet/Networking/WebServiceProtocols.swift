//
//  WebServiceProtocols.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol WebServiceProtocols {
   func request(url: URL?, requestType: RequestType,  params: [String: Any]?, completion: @escaping (Result<Data, HTError>?) -> Void)
}
