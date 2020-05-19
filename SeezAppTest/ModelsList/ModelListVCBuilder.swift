//
//  ModelListVCBuilder.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

class ModelListVCBuilder {
    class func buildModule(on vc: ModelListViewControllerProtocol, models:List<RealmModel>) {
       let interactor = ModelListInteractor(presenter: ModelListPresenter(view: vc), models: models)
        vc.interactor = interactor
    }
    
}
