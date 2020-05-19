//
//  VehicleSelectionInteractor.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation


protocol VehicleSelectionInteractorProtocol {
    func fetchVehicleSpecs()
    func selected(make: RealmMake)
    func selected(model: RealmModel)
    func selected(subModel: RealmSubModel)
    func setModels()
    func setSubModels()
    func setMakes()
}

class VehicleSelectionInteractor: VehicleSelectionInteractorProtocol {
    
    var vehicleLoader: VehicleDataSyncProtocol
    var presenter: VehicleSelectionPresenterProtocol
    var selectedMake: RealmMake?
    var selectedModel: RealmModel?
    var selectedSubModel: RealmSubModel?
    
    init(presenter: VehicleSelectionPresenterProtocol, vehicleLoader: VehicleDataSyncProtocol) {
        self.presenter = presenter
        self.vehicleLoader = vehicleLoader
    }
    
    func fetchVehicleSpecs() {
        vehicleLoader.fetchAll { [weak self] in
            self?.presenter.vehicleSpecsFetched()
        }
    }
    
    func selected(make: RealmMake) {
        self.selectedMake = make
    }
    
    func selected(model: RealmModel) {
        self.selectedModel = model
    }
    
    func selected(subModel: RealmSubModel) {
        self.selectedSubModel = subModel
    }
    
    func setModels() {
        guard let models = self.selectedMake?.models else {
            return
        }
        self.presenter.showModelsScreen(with: models)
    }
    
    func setSubModels() {
        guard let subModels = self.selectedModel?.subModels else {
            return
        }
        self.presenter.showSubModelsScreen(with: Array(subModels))
    }
    
    func setMakes() {
        let makes = RealmMake.all()
        self.presenter.showMakesScreen(with: Array(makes))
        
    }
}

