//
//  VehicleSelectionPresenterMock.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import RealmSwift
@testable import SeezAppTest


class VehicleSelectionPresenterMock: VehicleSelectionPresenterProtocol {
    
    
    var isVehicleSpecsFetchedCalled = false
    var makes:[RealmMake]?
    var models:List<RealmModel>?
    var subModels:[RealmSubModel]?
    
    func vehicleSpecsFetched() {
        isVehicleSpecsFetchedCalled = true
    }
    
    func showMakesScreen(with makes:[RealmMake]) {
        self.makes = makes
    }
    
    func showModelsScreen(with models:List<RealmModel>) {
        self.models = models
    }
    
    func showSubModelsScreen(with subModels:[RealmSubModel]) {
        self.subModels = subModels
    }
}
