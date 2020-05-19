//
//  Model.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmModel: Object {
  @objc dynamic var active = false
  @objc dynamic var bodyTypeId = ""
  @objc dynamic var createdAt = ""
  @objc dynamic var id = ""
  @objc dynamic var name = ""
  @objc dynamic var updatedAt = ""
  @objc dynamic var makeId = ""
  let subModels = LinkingObjects(fromType: RealmSubModel.self, property: "models")
    
  override static func primaryKey() -> String? {
        return "id"
    }
}
