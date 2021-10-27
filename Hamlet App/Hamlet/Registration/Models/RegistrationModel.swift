//
//  RegistrationModel.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct SignupRequestModel {
    let userType: Int
    let name: String
    let email: String
    let password: String
    let dob: String
    let gender: String
    let phone: Int
    let countryId: Int
    let chatLanguageId: Int
    let profilePicture: String
}
