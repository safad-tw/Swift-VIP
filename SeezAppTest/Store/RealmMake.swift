//
//  Make.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMake: Object {
  @objc dynamic var active = false
  @objc dynamic var createdAt = ""
  @objc dynamic var id = ""
  @objc dynamic var logoUri = ""
  @objc dynamic var name = ""
  @objc dynamic var updatedAt = ""
  let models = List<RealmModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - CRUD methods
extension RealmMake {
  static func all(in realm: Realm = try! Realm()) -> Results<RealmMake> {
    return realm.objects(RealmMake.self)
    }
    
    static func get(for id: String, in realm: Realm = try! Realm()) -> RealmMake? {
        return realm.object(ofType: RealmMake.self, forPrimaryKey: id) 
    }
}
