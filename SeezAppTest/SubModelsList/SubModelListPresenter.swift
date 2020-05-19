//
//  SubModelListPresenter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

protocol SubModelListPresenterProtocol {
    func show(subModels: [RealmSubModel])
}

class SubModelListPresenter {
    
    weak var view: SubModelListViewControllerProtocol?
    
    init(view:SubModelListViewControllerProtocol) {
        self.view = view
    }

}

extension SubModelListPresenter:SubModelListPresenterProtocol {
    func show(subModels: [RealmSubModel]) {
        self.view?.show(subModels: subModels)
    }
}

