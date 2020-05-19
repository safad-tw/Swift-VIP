//
//  SubModel.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSubModel: Object {
  @objc dynamic var active = false
  @objc dynamic var createdAt = ""
  @objc dynamic var id = ""
  @objc dynamic var makeId = ""
  @objc dynamic var name = ""
  @objc dynamic var updatedAt = ""
  let models = List<RealmModel>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
