//
//  Utility.swift
//  StopWatchApp
//
//  Created by Chaman Sharma on 12/07/21.
//

import UIKit

func computeNewDate(from fromDate: Date, to toDate: Date) -> Date  {
     let delta = toDate.timeIntervalSince(fromDate)
     let today = Date()
     if delta < 0 {
         return today
     } else {
         return today.addingTimeInterval(delta)
     }
}
