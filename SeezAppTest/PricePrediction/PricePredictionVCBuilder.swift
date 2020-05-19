//
//  PricePredictionBuilder.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

class PricePredictionVCBuilder {
    class func buildModule(on vc: PricePredictionViewControllerProtocol,
                           make: RealmMake,
                           subModel:RealmSubModel? = nil,
                           model: RealmModel? = nil) {
        let presenter = PricePredictionPresenter(view: vc)
        let worker = VehicleWorker(networkManager: NetworkManager())
        let interactor = PricePredictionInteractor(presenter: presenter,makeId: make.id, modelId:model?.id, subModelId: subModel?.id,  worker: worker)
        vc.interactor = interactor
    }
    
}
