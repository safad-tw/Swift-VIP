//
//  StoreCoordinatorSpec.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//
import Quick
import Nimble
import SwiftyJSON
import RealmSwift
@testable import SeezAppTest

class StoreCoordinatorSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        let jsonReader = JSONReader()
        let makes:[Make] = try! JSONDecoder().decode([Make].self, from: jsonReader.readResponseFrom(fileName: "makes"))
        let models: [Model] = try! JSONDecoder().decode([Model].self, from: jsonReader.readResponseFrom(fileName: "models"))
        let submodels: [SubModel] = try! JSONDecoder().decode([SubModel].self, from: jsonReader.readResponseFrom(fileName: "submodels"))
        
        beforeSuite {
            Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        }
        
        beforeEach {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }
        
        describe("Test for realm crud operations") {
            it("Insert makes, models and submodels into realm db") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let makesFromDatabase = realm.objects(RealmMake.self)
                    let modelsFromDatabase = realm.objects(RealmModel.self)
                    let subModelsFromDatabase = realm.objects(RealmSubModel.self)
                    
                    expect(makesFromDatabase.count) == 92
                    expect(modelsFromDatabase.count) == 1022
                    expect(subModelsFromDatabase.count) == 932
                }
            }
            
            it("Should check whether make is inserted properly with values") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let makeFromDatabase = realm.objects(RealmMake.self).first
                    
                    expect(makeFromDatabase?.name).notTo(beNil())
                    expect(makeFromDatabase?.id).notTo(beNil())
                    expect(makeFromDatabase?.active).notTo(beNil())
                    expect(makeFromDatabase?.models).notTo(beNil())
                    expect(makeFromDatabase?.updatedAt).notTo(beNil())
                    expect(makeFromDatabase?.createdAt).notTo(beNil())
                    
                }
            }
            
            it("Should check whether model is inserted properly with values") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let modelFromDatabase = realm.objects(RealmModel.self).first
                    
                    expect(modelFromDatabase?.name).notTo(beNil())
                    expect(modelFromDatabase?.id).notTo(beNil())
                    expect(modelFromDatabase?.active).notTo(beNil())
                    expect(modelFromDatabase?.makeId).notTo(beNil())
                    expect(modelFromDatabase?.subModels).notTo(beNil())
                    expect(modelFromDatabase?.updatedAt).notTo(beNil())
                    expect(modelFromDatabase?.createdAt).notTo(beNil())
                    
                }
            }
            
            it("Should check whether submodel is inserted properly with values") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let subModelFromDatabase = realm.objects(RealmSubModel.self).first
                    
                    expect(subModelFromDatabase?.name).notTo(beNil())
                    expect(subModelFromDatabase?.id).notTo(beNil())
                    expect(subModelFromDatabase?.active).notTo(beNil())
                    expect(subModelFromDatabase?.makeId).notTo(beNil())
                    expect(subModelFromDatabase?.models).notTo(beNil())
                    expect(subModelFromDatabase?.updatedAt).notTo(beNil())
                    expect(subModelFromDatabase?.createdAt).notTo(beNil())
                    
                }
            }
        }
        
        
        describe("Spec for one to many relationship") {
            it("Should check makes has models") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let makeFromDatabase = realm.objects(RealmMake.self).first
                    expect(makeFromDatabase?.models.count) == 20
                }
            }
        }
        
        describe("Spec for many to many relationship") {
            it("Should check model has sub models") {
                StoreCoordinator.save(makes: makes, models: models, subModels: submodels) {
                    let realm = try! Realm()
                    let modelFromDatabase = realm.objects(RealmModel.self).first
                    expect(modelFromDatabase?.subModels.count) == 3
                }
            }
        }
    }
}


