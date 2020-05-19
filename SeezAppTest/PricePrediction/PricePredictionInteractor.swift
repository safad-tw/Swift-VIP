//
//  PricePredictionInteractor.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import Alamofire

protocol PricePredictionInteractorProtocol {
    func fetchPredictPrice(for year: String)
}

class PricePredictionInteractor: PricePredictionInteractorProtocol {
    
    var presenter:PricePredictionPresenterProtocol
    var makeId:String
    var modelId:String?
    var subModelId:String?
    var worker: VehicleProtocol
    var price:Price?
    
    init(presenter: PricePredictionPresenterProtocol, makeId:String, modelId:String? = nil,subModelId:String?=nil, worker: VehicleProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.makeId = makeId
        self.modelId = modelId
        self.subModelId = subModelId
    }
    
    func fetchPredictPrice(for year: String) {
        var parameters:Parameters = ["make_id": self.makeId,
                                     "year": year]
        
        if let modelId = self.modelId {
            parameters["model_id"] = modelId
        }
        if let submodelId = self.subModelId {
            parameters["submodel_id"] = submodelId
        }
        
        self.worker.fetchPredictPrice(parameters: parameters,
                                      onSuccess: { (price) in
                                        self.price = price
                                        self.presenter.show(price:price)
        }) {
            self.presenter.failedToFetchPrice()
        }
    }
    
}
