//
//  ModelListInteractor.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

protocol ModelListInteractorProtocol {
    func loadModels()
}

class ModelListInteractor: ModelListInteractorProtocol {
    
    var presenter:ModelListPresenterProtocol
    var models:List<RealmModel>
    
    init(presenter: ModelListPresenterProtocol, models:List<RealmModel>) {
        self.presenter = presenter
        self.models = models
    }
    
    func loadModels() {
        self.presenter.show(models: models)
    }
    
}
