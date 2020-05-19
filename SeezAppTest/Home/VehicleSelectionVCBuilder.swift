//
//  VehicleSelectionBuilder.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

class VehicleSelectionVCBuilder {
    
    class func buildModule(on vc: VehicleSelectionViewControllerProtocol) {
        let presenter = VehicleSelectionPresenter(view: vc)
        let vehicleloader = VehicleDataSync(worker: VehicleWorker(networkManager: NetworkManager()))
        let interactor = VehicleSelectionInteractor(presenter: presenter, vehicleLoader: vehicleloader)
        vc.router = VehicleSelectionRouter()
        vc.interactor = interactor
    }
    
}


