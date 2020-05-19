//
//  SubModelListBuilder.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/13/20.
//  Copyright © 2020 SAAL. All rights reserved.
//
import Foundation
import RealmSwift

class SubModelListVCBuilder {
    class func buildModule(on vc: SubModelListViewControllerProtocol, subModels:[RealmSubModel]) {
       let interactor = SubModelListInteractor(presenter: SubModelListPresenter(view: vc), subModels: subModels)
        vc.interactor = interactor
    }
    
}
