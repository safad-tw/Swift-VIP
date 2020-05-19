//
//  VehicleSelectionViewControllerSpec.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Quick
import Nimble
@testable import SeezAppTest

class VehicleSelectionViewControllerSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        var vehicleSelectionVC:VehicleSelectionViewController!
        var interactor: VehicleSelectionInteractorMock!
        
        describe("Spec for VehicleSelectionViewController") {
            
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                vehicleSelectionVC=storyboard.instantiateViewController(withIdentifier: "VehicleSelectionViewController") as? VehicleSelectionViewController
                interactor = VehicleSelectionInteractorMock()
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.beginAppearanceTransition(true, animated: false)
                vehicleSelectionVC.endAppearanceTransition()
            }
            
            it ("Should call interactor fetch vehicle method") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.viewDidLoad()
                expect(interactor.isVehicleSpecsFetchedCalled).to(beTrue())
            }
            
            it ("Should call interactor set make call method") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.selectMake(self)
                expect(interactor.isSetMakeCalled).to(beTrue())
            }
            
            it ("Should not call interactor set model call if make is not selected") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.selectModel(self)
                expect(interactor.isSetModelCalled).to(beFalse())
            }
            
            it ("Should call interactor set model call if make is selected") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.selectedMake = RealmMake()
                vehicleSelectionVC.selectModel(self)
                expect(interactor.isSetModelCalled).to(beTrue())
            }
            
            it ("Should not call interactor set sub model methid if model is not selected") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.selectSubmodel(self)
                expect(interactor.isSetSubModelCalled).to(beFalse())
            }
            
            it ("Should call interactor set sub model call if model and make is selected") {
                vehicleSelectionVC.interactor = interactor
                vehicleSelectionVC.selectedMake = RealmMake()
                vehicleSelectionVC.selectedModel = RealmModel()
                vehicleSelectionVC.selectSubmodel(self)
                expect(interactor.isSetSubModelCalled).to(beTrue())
            }
            
            it ("Should set make on interactor on selection") {
                vehicleSelectionVC.interactor = interactor
                let make = RealmMake()
                make.updatedAt = "2019-08-29T02:48:48.167175+02:00"
                vehicleSelectionVC.selected(make:make)
                expect(interactor.make) === make
            }
            
            it ("Should set model on interactor on selection") {
                vehicleSelectionVC.interactor = interactor
                let model = RealmModel()
                
                vehicleSelectionVC.selected(model:model)
                expect(interactor.model) === model
            }
            
            it ("Should set sub model on interactor on selection") {
                vehicleSelectionVC.interactor = interactor
                let submodel = RealmSubModel()
                
                vehicleSelectionVC.selected(subModel:submodel)
                expect(interactor.subModel) === submodel
            }
            
            
            
        }
        
        
        
    }
    
}
