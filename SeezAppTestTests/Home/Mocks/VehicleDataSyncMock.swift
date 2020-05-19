//
//  VehicleLoaderMock.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//
import SwiftyJSON
import Alamofire
@testable import SeezAppTest


class VehicleDataSyncMock: VehicleDataSyncProtocol {
    
    var isFetchAllCalled = false
    func fetchAll(onCompletion:@escaping () -> Void) {
        isFetchAllCalled = true
        onCompletion()
    }
}
