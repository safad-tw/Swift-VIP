//
//  SubModel.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

struct SubModel: Codable {
    var active: Bool
    var created_at: String
    var id: String
    var make_id: String?
    var model_id: String
    var model_ids: [String]
    var name:String
    var trim_ids: [String]
    var updated_at: String
}
