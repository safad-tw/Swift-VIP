//
//  VehicleSelectionRouter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

protocol VehicleSelectionRouterProtocol {
    func showModelsScreen(models: List<RealmModel>)-> UIViewController
    func showMakeScreen(makes: [RealmMake])-> UIViewController
    func showSubModelsScreen(subModels:[RealmSubModel]) -> UIViewController
    func showPricePredictionScreen(selectedMake: RealmMake,                                        selectedModel: RealmModel?,
                                   selectedSubModel: RealmSubModel?) -> UIViewController
}

class VehicleSelectionRouter: VehicleSelectionRouterProtocol {
    
    func showModelsScreen(models: List<RealmModel>)-> UIViewController {
        guard let vC = mainStoryboard.instantiateViewController(withIdentifier: "ModelListViewController") as? ModelListViewController
            else { return UIViewController() }
        ModelListVCBuilder.buildModule(on: vC, models: models)
        return vC
    }
    
   func showMakeScreen(makes: [RealmMake])-> UIViewController {
        guard let vC = mainStoryboard.instantiateViewController(withIdentifier: "MakeViewController") as? MakeViewController
            else { return UIViewController() }
    MakeVCBuilder.buildModule(on: vC, makes: makes)
        return vC
    }
    
    func showSubModelsScreen(subModels:[RealmSubModel]) -> UIViewController {
        guard let vC = mainStoryboard.instantiateViewController(withIdentifier: "SubModelListViewController") as? SubModelListViewController
            else { return UIViewController() }
        SubModelListVCBuilder.buildModule(on: vC, subModels: subModels)
        return vC
    }
    
    func showPricePredictionScreen(selectedMake: RealmMake,                                        selectedModel: RealmModel?=nil,
                                   selectedSubModel: RealmSubModel?=nil) -> UIViewController {
        guard let vC = mainStoryboard.instantiateViewController(withIdentifier: "PricePredictionViewController") as? PricePredictionViewController
            else { return UIViewController() }
        PricePredictionVCBuilder.buildModule(on: vC, make: selectedMake, subModel: selectedSubModel, model: selectedModel)
        return vC
    }
    
    
    private var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
