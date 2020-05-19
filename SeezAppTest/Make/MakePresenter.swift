//
//  MakePresenter.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

protocol MakePresenterProtocol {
    func showMakes(makes:[RealmMake])
}

class MakePresenter {
    
    weak var view: MakeViewControllerProtocol?
    
    init(view:MakeViewControllerProtocol) {
        self.view = view
    }
}

extension MakePresenter:MakePresenterProtocol {
    func showMakes(makes:[RealmMake]) {
        self.view?.show(makes: makes)
    }
}
