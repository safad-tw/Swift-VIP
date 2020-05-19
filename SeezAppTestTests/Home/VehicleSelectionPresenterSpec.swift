//
//  VehicleSelectionPresenterSpec.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON
import RealmSwift
@testable import SeezAppTest

class VehicleSelectionPresenterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("Spec for VehicleSelectionPresenter") {
            
            var viewMock: VehicleSelectionVCMock!
            var presenter: VehicleSelectionPresenter!
            
            beforeEach {
                viewMock = VehicleSelectionVCMock()
                presenter = VehicleSelectionPresenter(view: viewMock)
            }
            
            
            
            it("Should call VC vehicleSpecsFetched method") {
                presenter.vehicleSpecsFetched()
                expect(viewMock.isVehicleSpecsFetchedCalled).to(beTrue())
            }
            
            it("Should call VC showMakesScreen method with data") {
                presenter.showMakesScreen(with: [RealmMake()])
                expect(viewMock.makes).notTo(beNil())
            }
            
            it("Should call VC showSubModelScreen method with data") {
                presenter.showSubModelsScreen(with: [RealmSubModel()])
                expect(viewMock.subModels).notTo(beNil())
            }
        }
        
    }
}
