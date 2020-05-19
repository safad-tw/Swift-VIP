//
//  VehicleSelectionPresenter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift


protocol VehicleSelectionPresenterProtocol {
    func vehicleSpecsFetched()
    func showMakesScreen(with makes:[RealmMake])
    func showModelsScreen(with models:List<RealmModel>)
    func showSubModelsScreen(with subModels:[RealmSubModel])
}

class VehicleSelectionPresenter{
    
    weak var view: VehicleSelectionViewControllerProtocol?
    
    init(view:VehicleSelectionViewControllerProtocol) {
        self.view = view
    }
}

extension VehicleSelectionPresenter:VehicleSelectionPresenterProtocol {
    
    func vehicleSpecsFetched() {
        self.view?.vehicleSpecsFetched()
    }
    
    func showMakesScreen(with makes:[RealmMake]){
         self.view?.showMakesScreen(with:makes)
    }
    
    func showModelsScreen(with models:List<RealmModel>) {
        self.view?.showModelsScreen(with:models)
    }
    
    func showSubModelsScreen(with subModels:[RealmSubModel]) {
         self.view?.showSubModelsScreen(with: subModels)
    }
}
