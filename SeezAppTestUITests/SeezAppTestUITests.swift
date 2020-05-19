//
//  SeezAppTestUITests.swift
//  SeezAppTestUITests
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import XCTest

class SeezAppTestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let app = XCUIApplication()
        app.launch()
//        let chooseMakeButton = app.buttons["Choose Make"]
//        chooseMakeButton.tap()
//
//        let tablesQuery = app.tables
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["RAM"]/*[[".cells.staticTexts[\"RAM\"]",".staticTexts[\"RAM\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        chooseMakeButton.tap()
//        app.buttons["Choose a Model"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Wrangler Unlimited"]/*[[".cells.staticTexts[\"Wrangler Unlimited\"]",".staticTexts[\"Wrangler Unlimited\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Choose a Submodel"].tap()
//        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Rubicon"]/*[[".cells.staticTexts[\"Rubicon\"]",".staticTexts[\"Rubicon\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.buttons["Go to Predict price"].tap()
//        app.buttons["Predict"].tap()
//        app.staticTexts["Predicted price is : 137377 AED"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
