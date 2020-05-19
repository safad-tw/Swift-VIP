//
//  VehicleWorker.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import Alamofire

protocol VehicleProtocol {
    func fetchAllMakes(onSuccess: @escaping ([Make]) -> Void,
                       onFailure: @escaping () -> Void)
    func fetchAllModels(onSuccess: @escaping ([Model]) -> Void,
                        onFailure: @escaping () -> Void)
    func fetchAllSubModels(onSuccess: @escaping ([SubModel]) -> Void,
                           onFailure: @escaping () -> Void)
    func fetchPredictPrice(parameters: Parameters,
                           onSuccess: @escaping (Price) -> Void,
                           onFailure: @escaping () -> Void)
}

enum VehicleTarget {
    case fetchAllMakes,
    fetchAllModels,
    fetchAllSubModels,
    fetchPredictPrice(parameters:Parameters)
}

extension VehicleTarget: NetworkRequest {
    var endpoint: String {
        switch self {
        case .fetchAllMakes:
            return "/static/makes/"
        case .fetchAllModels:
            return "/static/models/"
        case .fetchAllSubModels:
            return "/static/submodels/"
        case .fetchPredictPrice:
            return "/v1/predict/price"
        }
        
    }
    var parameters: Parameters {
        switch self {
        case .fetchAllMakes,.fetchAllModels, .fetchAllSubModels:
            return [:]
        case .fetchPredictPrice(let parameters) :
            return parameters
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchAllMakes,.fetchAllModels, .fetchAllSubModels, .fetchPredictPrice:
            return .get
        }
    }
}

final class VehicleWorker: VehicleProtocol {
    
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchAllMakes(onSuccess: @escaping ([Make]) -> Void,
                       onFailure: @escaping () -> Void)
    {
        networkManager.request(VehicleTarget.fetchAllMakes) { (isSuccess, _ , data) in
            guard isSuccess, let data = data else {
                onFailure()
                return
            }
            let makes = try! JSONDecoder().decode([Make].self, from: data)
            onSuccess(makes)
            
        }
    }
    
    func fetchAllModels(onSuccess: @escaping ([Model]) -> Void,
                        onFailure: @escaping () -> Void) {
        networkManager.request(VehicleTarget.fetchAllModels) { (isSuccess, _, data) in
            guard isSuccess, let data = data else {
                onFailure()
                return
            }
            let models = try! JSONDecoder().decode([Model].self, from: data)
            onSuccess(models)
        }
        
    }
    
    func fetchAllSubModels(onSuccess: @escaping ([SubModel]) -> Void,
                           onFailure: @escaping () -> Void) {
        networkManager.request(VehicleTarget.fetchAllSubModels) { (isSuccess, _, data) in
            guard isSuccess, let data = data else {
                onFailure()
                return
            }
            let subModels = try! JSONDecoder().decode([SubModel].self, from: data)
            onSuccess(subModels)
        }
        
    }
    
    func fetchPredictPrice(parameters: Parameters,
                              onSuccess: @escaping (Price) -> Void,
                              onFailure: @escaping () -> Void) {
        
        let target = VehicleTarget.fetchPredictPrice(parameters: parameters)
        networkManager.request(target) { (isSuccess, _, data) in
            guard isSuccess, let data = data else {
                onFailure()
                return
            }
            let price = try! JSONDecoder().decode(Price.self, from: data)
            onSuccess(price)
        }
        
        
    }
}
