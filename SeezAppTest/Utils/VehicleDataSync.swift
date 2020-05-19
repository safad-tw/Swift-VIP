//
//  VehicleLoader.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

//MARK : Protocol
protocol VehicleDataSyncProtocol {
    func fetchAll(onCompletion:@escaping () -> Void)
}

//MARK : Class
class VehicleDataSync:VehicleDataSyncProtocol {
    
    private var worker: VehicleWorker
    private var models:[Model]
    private var subModels:[SubModel]
    private var makes:[Make]

    init(worker: VehicleWorker) {
        self.worker = worker
        self.models = [Model]()
        self.subModels = [SubModel]()
        self.makes = [Make]()
    }
    
    //MARK : Methods
    func fetchAll(onCompletion:@escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        self.worker.fetchAllMakes(onSuccess: { (makes) in
            self.makes = makes
            group.leave()
            print("makes fecthed with operation")
            
        }) {
            group.leave()
            print("error")
        }
        
        
        group.enter()
        self.worker.fetchAllModels(onSuccess: { (models) in
            self.models = models
            group.leave()
        }) {
            print("error")
            group.leave()
        }
        
        group.enter()
        
        self.worker.fetchAllSubModels(onSuccess: { (submodels) in
            self.subModels = submodels
            group.leave()
        }) {
            print("error")
            group.leave()
        }
        
        
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            print("All async calls completed")
            StoreCoordinator.save(makes: self.makes, models: self.models, subModels: self.subModels, onCompletion: onCompletion)
        }
        
    }
}





