//
//  DateFormatterUtil.swift
//  SeezAppTest
//
//  Created by Mohammad Safad on 5/14/20.
//  Copyright © 2020 SAAL. All rights reserved.
//

import Foundation


class DateFormatterUtil {

    static func convertToDateFormatInString(stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let date = dateFormatter.date(from:stringDate)!
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
}
