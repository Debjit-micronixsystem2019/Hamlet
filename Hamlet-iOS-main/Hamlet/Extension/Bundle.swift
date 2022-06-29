//
//  Bundle.swift
//  Hamlet
//
//  Created by admin on 10/22/21.
//  Copyright © 2021 Amit. All rights reserved.
//

import Foundation
import UIKit


struct BuildConstant {
    public static let appBundleIdentifier = "com.micronix.arlenecaringal.dentalclinic"
}

extension Bundle {
    public static var appBundle: Bundle? {
        return Bundle(identifier: BuildConstant.appBundleIdentifier)
    }
}
