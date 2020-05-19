//
//  JSONReader.swift
//  SeezAppTestTests
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation

class JSONReader {
    func readResponseFrom(fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .alwaysMapped)
                return data
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
        return Data()
    }

}
