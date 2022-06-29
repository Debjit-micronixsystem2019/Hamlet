//
//  PlanModel.swift
//  "Hamlet!"
//
//  Created by Basir Alam on 18/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit


struct PlanModel : Codable{
    let data : PlantData?
    let status : String?
}
struct PlantData : Codable{
    let plan : String?
    let expire_date: String?;
}
