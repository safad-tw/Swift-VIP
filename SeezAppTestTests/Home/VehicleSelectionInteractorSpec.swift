//
//  VehicleSelectionInteractorSpec.swift
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

class VehicleSelectionInteractorSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("Spec for VehicleSelectionInteractor") {
            
            let jsonReader = JSONReader()
            let makes:[Make] = try! JSONDecoder().decode([Make].self, from: jsonReader.readResponseFrom(fileName: "makes"))
            let models: [Model] = try! JSONDecoder().decode([Model].self, from: jsonReader.readResponseFrom(fileName: "models"))
            let submodels: [SubModel] = try! JSONDecoder().decode([SubModel].self, from: jsonReader.readResponseFrom(fileName: "submodels"))
            
            var loader: VehicleDataSyncMock!
            var presenter: VehicleSelectionPresenterMock!
            var interactor: VehicleSelectionInteractor!
            
            beforeSuite {
                Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
            }
            
            beforeEach {
                let realm = try! Realm()
                try! realm.write {
                    realm.deleteAll()
                }
                
                loader = VehicleDataSyncMock()
                presenter = VehicleSelectionPresenterMock()
                interactor = VehicleSelectionInteractor(presenter: presenter, vehicleLoader: loader)
            }
            
            describe("spec for fetchVehicle method"){
                it("should verify loader method is called"){
                    
                    interactor.fetchVehicleSpecs()
                    expect(loader.isFetchAllCalled).to(beTrue())
                }
            }
            
            describe("spec for selected make method"){
                it("should verify selected make is set"){
                    
                    let realmMake = RealmMake()
                    interactor.selected(make: realmMake)
                    expect(interactor.selectedMake) === realmMake
                }
            }
            
            describe("spec for selected model method"){
                it("should verify selected model is set"){
                    
                    let realmModel = RealmModel()
                    interactor.selected(model: realmModel)
                    expect(interactor.selectedModel) === realmModel
                }
            }
            
            
            describe("spec for selected submodel method"){
                it("should verify selected model is set"){
                    let realmSubModel = RealmSubModel()
                    interactor.selected(subModel: realmSubModel)
                    expect(interactor.selectedSubModel) === realmSubModel
                }
            }
            
            describe("spec for setmakes method"){
                it("should call presenter method on set"){
                    StoreCoordinator.save(makes: makes, models: models, subModels: submodels){}
                    interactor.setMakes()
                    expect(presenter.makes).notTo(beNil())
                }
            }
            
            describe("spec for setmodels method"){
                it("should call presenter method on set"){
                    StoreCoordinator.save(makes: makes, models: models, subModels: submodels){}
                    let realm = try! Realm()
                    let firstMake = realm.objects(RealmMake.self).first
                    interactor.selected(make: firstMake!)
                    interactor.setModels()
                    expect(presenter.models).notTo(beNil())
                }
            }
            
            describe("spec for setmakes method"){
                it("should call presenter method on set"){
                    StoreCoordinator.save(makes: makes, models: models, subModels: submodels){}
                    let realm = try! Realm()
                    let firstModel = realm.objects(RealmModel.self).first
                    interactor.selected(model: firstModel!)
                    interactor.setSubModels()
                    expect(presenter.subModels).notTo(beNil())
                }
            }
            
        }
    }
    
}
