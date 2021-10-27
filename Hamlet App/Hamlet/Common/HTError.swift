//
//  JMTError.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

enum HTError: Error, Equatable {
    
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidRequest
    case notFound
    case noData
    case invalidResponse
    case serverError(message: String)
    case internalError(message: String)
    case serverUnavailable
    case timeOut
    case unsuppotedURL
    case emailExists
    
    static func checkErrorCode(_ errorCode: Int?) -> HTError {
        switch errorCode {
        case 399:
            return .unknownError
        case 401:
            return .connectionError
        case 404:
            return .invalidCredentials
        case 405:
            return .invalidRequest
        case 406:
            return .notFound
        case 407:
            return .invalidResponse
        case 400:
            return .serverError(message: "")
        case 409:
            return .serverUnavailable
        case 410:
            return .timeOut
        default:
            return .unsuppotedURL
        }
    }
    
    var description: String {
        switch self {
        case .unsuppotedURL:
            return Constants.invalidURL
        case .serverError(let errMessage):
            return errMessage
        case .internalError(let errMessage):
            return errMessage
        case .invalidRequest:
            return Constants.invalidRequest
        case .noData:
            return Constants.noData
        case .emailExists:
            return Constants.emailExists
        default:
            return "Error!"
        }
    }
}
