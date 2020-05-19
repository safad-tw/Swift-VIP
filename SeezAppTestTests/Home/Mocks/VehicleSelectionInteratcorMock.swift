//
//  VehicleSelectionInteratcorMock.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import RealmSwift
@testable import SeezAppTest


class VehicleSelectionInteractorMock: VehicleSelectionInteractorProtocol {
    
    var isVehicleSpecsFetchedCalled = false
    var isSetModelCalled = false
    var isSetMakeCalled = false
    var isSetSubModelCalled = false
    var make:RealmMake?
    var model:RealmModel?
    var subModel:RealmSubModel?
    
    func fetchVehicleSpecs() {
        isVehicleSpecsFetchedCalled = true
    }
    
    func selected(make: RealmMake) {
        self.make = make
    }
    
    func selected(model: RealmModel) {
        self.model = model
    }
    
    func selected(subModel: RealmSubModel) {
        self.subModel = subModel
    }
    
    func setModels() {
        isSetModelCalled = true
    }
    
    func setSubModels() {
        isSetSubModelCalled = true
    }
    
    func setMakes() {
        isSetMakeCalled = true
    }
    
}
