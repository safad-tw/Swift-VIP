//
//  ModelListPresenter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

protocol ModelListPresenterProtocol {
    func show(models: List<RealmModel>)
}

class ModelListPresenter {
    
    weak var view: ModelListViewControllerProtocol?
    
    init(view:ModelListViewControllerProtocol) {
        self.view = view
    }

}

extension ModelListPresenter:ModelListPresenterProtocol {
    func show(models: List<RealmModel>) {
        self.view?.show(models: models)
    }
}
