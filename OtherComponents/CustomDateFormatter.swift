//
//  DateFormatter.swift
//  JamFuel
//
//  Created by apple on 09/05/19.
//  Copyright © 2019 Anvi. All rights reserved.
//

import UIKit

class CustomDateFormatter: NSObject {
    static func getDateFromString(strDate: String, requiredDateFormat : String) -> Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatterGet.dateFormat = requiredDateFormat
        return dateFormatterGet.date(from: strDate)!
    }
    
    static func getStringFromDate(date: Date, requiredDateFormat : String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = requiredDateFormat
        dateFormatterGet.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatterGet.string(from: date)
    }
}
