//
//  Enviornment.swift
//  WorkMate
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2019 Mohammad Safad. All rights reserved.
//

import Foundation

enum PlistKey {
    case baseURL
   
    func value() -> String {
        switch self {
        case .baseURL:
            return "baseURL"
        }
    }
}

struct Environment {

    fileprivate var infoDict: [String: Any] {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    
    func configuration(_ key: PlistKey) -> String {
        switch key {
        case .baseURL:
            return infoDict[PlistKey.baseURL.value()] as! String
        }
    }
}

