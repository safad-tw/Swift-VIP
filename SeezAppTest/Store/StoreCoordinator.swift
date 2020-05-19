//
//  StoreCoordinator.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

class StoreCoordinator {
    
    
    static func save(makes:[Make],
                     models:[Model],
                     subModels:[SubModel],
                     onCompletion:@escaping () -> Void) {
        
        let realm = try! Realm()
        try! realm.write {
            for model in models {
                if model.active{
                    let realmModel = RealmModel()
                    realmModel.active = model.active
                    realmModel.createdAt = model.created_at
                    realmModel.id = model.id
                    realmModel.name = model.name
                    realmModel.makeId = model.make_id
                    realm.create(RealmModel.self, value: realmModel, update: .all)
                }
            }
            
            for subModel in subModels {
                if subModel.active {
                    let realmSubModel = RealmSubModel()
                    realmSubModel.active = subModel.active
                    realmSubModel.createdAt = subModel.created_at
                    realmSubModel.id = subModel.id
                    realmSubModel.name = subModel.name
                    realmSubModel.makeId = subModel.make_id ?? ""
                    for id in subModel.model_ids {
                        if let object = realm.object(ofType: RealmModel.self, forPrimaryKey: id) {
                            realmSubModel.models.append(object)
                        }
                    }
                    realm.create(RealmSubModel.self, value: realmSubModel, update: .all)
                }
            }
            
            for make in makes {
                if make.active {
                    let realmMake = RealmMake()
                    realmMake.active = make.active
                    realmMake.createdAt = make.created_at
                    realmMake.id = make.id
                    realmMake.logoUri = make.logo_uri
                    realmMake.name = make.name
                    realmMake.updatedAt = make.updated_at
                    let models = realm.objects(RealmModel.self).filter("id contains '\(make.id)'")
                    realmMake.models.append(objectsIn: models)
                    
                    realm.create(RealmMake.self, value: realmMake, update: .all)
                }
            }
            
        }
        print(realm.configuration.fileURL?.absoluteString)
        onCompletion()
        
    }
    
}
