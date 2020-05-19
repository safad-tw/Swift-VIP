//
//  MakeInteractor.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation
import RealmSwift

protocol MakeInteractorProtocol {
    func fetchMakes()
}

class MakeInteractor: MakeInteractorProtocol {
    
    var presenter:MakePresenterProtocol
    var makes: [RealmMake]
    
    
    init(presenter: MakePresenterProtocol, makes:[RealmMake]) {
        self.presenter = presenter
        self.makes = makes
    }
    
    func fetchMakes() {
        self.presenter.showMakes(makes: makes)
    }
    
}
