//
//  AlertUtil.swift
//  FictionBooks
//
//  Created by Mohammad Safad on 5/12/20.
//  Copyright © 2020 lastminute. All rights reserved.
//

import UIKit

final class AlertUtil {
    
    class func show(on vc: UIViewController, title: String, message: String? = "" ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }

}
