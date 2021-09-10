//
//  TimeModel.swift
//  StopWatchApp
//
//  Created by Chaman Sharma on 12/07/21.
//

import UIKit

class TimeModel: NSObject {
    static var startTime: String {
        get {
            if let startTimeString = UserDefaults.standard.object(forKey: "StartTime") as? String {
                return startTimeString
            }
            return ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "StartTime")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var currentState: String {
        get {
            if let currentStateString = UserDefaults.standard.object(forKey: "CurrentState") as? String {
                return currentStateString
            }
            return ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "CurrentState")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var pauseTime: String {
        get {
            if let pauseTimeString = UserDefaults.standard.object(forKey: "PauseTime") as? String {
                return pauseTimeString
            }
            return ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "PauseTime")
            UserDefaults.standard.synchronize()
        }
    }
}
