//
//  SubModelListInteractor.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

protocol SubModelListInteractorProtocol {
    func loadSubModels()
}

class SubModelListInteractor: SubModelListInteractorProtocol {
    
    var presenter:SubModelListPresenterProtocol
    var subModels:[RealmSubModel]
    
    init(presenter: SubModelListPresenterProtocol, subModels:[RealmSubModel]) {
        self.presenter = presenter
        self.subModels = subModels
    }
    
    func loadSubModels() {
        self.presenter.show(subModels: subModels)
    }
    
}
