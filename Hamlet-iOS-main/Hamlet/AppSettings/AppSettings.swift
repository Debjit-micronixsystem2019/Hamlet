//
//  AppSettings.swift
//  Hamlet
//
//  Created by Amit on 10/09/21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

enum Defaults {
    static let localModeKey = "AppSettings.Hamlet.localModeKey"
    static let firstLaunchKey = "AppSettings.Hamlet.firstLaunchKey"
    static let firstLoggedInKey = "AppSettings.Hamlet.firstLoggedInKey"
    static let authKey = "AppSettings.Hamlet.authKey"
    static let loggedIn = "AppSettings.Hamlet.isLoggedIn"
    static let userId = "AppSettings.Hamlet.userId"
    static let userName = "AppSettings.Hamlet.userName"
    static let userEmail = "AppSettings.Hamlet.userEmail"
    static let userProfileUrl = "AppSettings.Hamlet.userProfileUrl"
    static let userChatLanguageId = "AppSettings.Hamlet.userChatLanguageId"
}

class AppSettings {
    static let shared = AppSettings()
    private init() {}
}

extension AppSettings {
    var localMode: Bool {
        return UserDefaults.standard.bool(forKey: Defaults.localModeKey)
    }
    
    var isFirstLaunch: Bool {
        return !UserDefaults.standard.bool(forKey: Defaults.firstLaunchKey)
    }
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Defaults.loggedIn)
    }
    
    var userId: Int {
        return UserDefaults.standard.integer(forKey: Defaults.userId) 
    }
    var userName: String {
        return UserDefaults.standard.string(forKey: Defaults.userName) ?? ""
    }
    var userEmail: String {
        return UserDefaults.standard.string(forKey: Defaults.userEmail) ?? ""
    }
    var userProfileUrl: String {
        return UserDefaults.standard.string(forKey: Defaults.userProfileUrl) ?? ""
    }
    
    var userChatLanguageId: Int {
        return UserDefaults.standard.integer(forKey: Defaults.userChatLanguageId)
    }
}


//MARK:- App Launch

class AppLaunch{
    static let shared = AppLaunch()
    
    var selectExpertisesSubmit: Bool {
        return UserDefaults.standard.bool(forKey: "selectExpertisesSubmit")
    }
    
    var selectProblemSubmit: Bool {
        return UserDefaults.standard.bool(forKey: "selectProblemSubmit")
    }
    
    var userName: String {
        return UserDefaults.standard.string(forKey: "UserName") ?? ""
    }
}
