//
//  DateFormatterUtilSpec.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//


import Quick
import Nimble
@testable import SeezAppTest

class DateFormatterUtilSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("Spec for DateFormatterUtilSpec") {
            
            it("should format time") {
                let time = "2019-08-29T02:48:48.167175+02:00"
                let dateInString = DateFormatterUtil.convertToDateFormatInString(stringDate: time)
                
                expect(dateInString).notTo(beNil())
                expect(dateInString).to(equal( "Aug 29, 2019 at 4:48:48 AM"))
            }
        }
    }
    
}
