//
//  AlertConstant.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct AlertConstants {
    static let done = "Done"
    static let cancel = "Cancel"
    static let ok = "OK"
    static let yes = "YES"
    static let no = "NO"
    static let alertTitle = "Alert"
    static let noInternet = "No Internet"
    static let noData = "Data not found"
    static let invalidRequest = "Invalid request parameters"
    static let invalidURL = "Invalid URL"
    static let updationError = "Failed to update"
    static let loading = "Loading..."

    static let fillDetail = "Please fill all the required detail."
    static let invalidCredential = "Invalid credential."
    static let invalidEmail = "Please enter valid email id."
    static let smallPassword = "Password is too small."
    static let enterPassword = "Please enter a long password."
    static let nonValidPassword = "Password must be at least 8 characters long, a capital letter and contain a number."
    static let doesNotMatchPassword = "Password doesn't match."
    static let smallName = "Please enter a valid name."
    static let faildAPiData = "Something went wrong please try after sometime."
    
    static let completed = "Completed"
    static let pending = "Pending"
    static let noWorkout = "No Workout"
    static let projectAlert = "Hamlet"
    static let textFieldBlank = "*Can't be blank"
    static let addtoCart = "The product is successfully added to your cart."
    static let addtoWishlist = "The product is successfully added to your wishlist."
    static let removetoWishlist = "The product is successfully removed to your wishlist."
    static let addedError = "Failed to added, try again after sometimes."
    static let removeError = "Failed to removed, try again after sometimes."

}

struct AlertFromApi {
    static let projectAlert = "Hamlet"
    static var message = ""
}
