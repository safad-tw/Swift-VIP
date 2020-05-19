//
//  ViewSelectionRouterSpec.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Quick
import Nimble
@testable import SeezAppTest

class ViewSelectionRouterSpec: QuickSpec {
    
    override func spec() {
        super.spec()
        
        describe("Spec for ViewSelectionRouter") {
            var router: VehicleSelectionRouterProtocol!
            
            beforeEach {
                router = VehicleSelectionRouter()
            }
            
            it("should return make view controller") {
                let vc = router.showMakeScreen(makes: [RealmMake()])
                expect(vc).notTo(beNil())
            }
            
            it("should return sub models view controller") {
                let vc = router.showSubModelsScreen(subModels: [RealmSubModel()])
                expect(vc).notTo(beNil())
            }
            
        }
        
    }
}
