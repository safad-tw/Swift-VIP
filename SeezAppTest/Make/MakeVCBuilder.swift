//
//  MakeVCBuilder.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

class MakeVCBuilder {
    
    class func buildModule(on vc: MakeViewControllerProtocol, makes:[RealmMake]) {
        let presenter = MakePresenter(view: vc)
        let interactor = MakeInteractor(presenter: presenter, makes: makes)
        vc.interactor = interactor
    }
    
}
