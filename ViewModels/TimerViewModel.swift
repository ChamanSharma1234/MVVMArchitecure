//
//  TimerViewModel.swift
//  StopWatchApp
//
//  Created by Chaman Sharma on 12/07/21.
//

import UIKit

enum TimerState : String {
    case Stop = "Stop"
    case Pause = "Pause"
    case Running = "Running"
}

protocol TimerProtocol {
    func currentTimerState(currentState: TimerState)
    func timerUpdate(currentTime: String)
}

class TimerViewModel {
    var delegate: TimerProtocol?
    var timer : Timer?
    
    //It is for checking the previous state on which app terminated
    func checkPreviousState() {
        if TimeModel.currentState == TimerState.Running.rawValue {
            timerStartAction()
        } else {
            timerStopResetAction()
        }
    }
    
    //Timer Start Action
    func timerStartAction() {
        //Saving Current state
        TimeModel.currentState = TimerState.Running.rawValue
        delegate?.currentTimerState(currentState: TimerState.Running)
        if TimeModel.startTime.isEmpty {
            //Saving the Timer StartTime
            TimeModel.startTime = CustomDateFormatter.getStringFromDate(date: Date(), requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
        }
        startTimer()
    }
    
    //It is for Stop/Reset Timer
    func timerStopResetAction() {
        TimeModel.currentState = TimerState.Stop.rawValue
        TimeModel.startTime = ""
        TimeModel.pauseTime = ""
        timer?.invalidate()
        delegate?.currentTimerState(currentState: TimerState.Stop)
        delegate?.timerUpdate(currentTime: "0 : 0 : 0")
    }
    
    //It is for Pause Timer
    func timerPauseAction() {
        //Stored the Pause Time
        TimeModel.pauseTime = CustomDateFormatter.getStringFromDate(date: Date(), requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
        //Stored Current state
        TimeModel.currentState = TimerState.Pause.rawValue
        timer?.invalidate()
        delegate?.currentTimerState(currentState: TimerState.Pause)
    }
    
    func timerResumeAction() {
        if !TimeModel.pauseTime.isEmpty {
            //Calculation the time interval from Pause tiem to Currrent Time
            let pauseTime = CustomDateFormatter.getDateFromString(strDate: TimeModel.pauseTime, requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
            let startTime = CustomDateFormatter.getDateFromString(strDate: TimeModel.startTime, requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
            let differenceDate = Calendar.current.dateComponents([.hour, .minute, .second], from: pauseTime, to: startTime)
            let newDate = Calendar.current.date(byAdding: differenceDate, to: Date())
            TimeModel.startTime = CustomDateFormatter.getStringFromDate(date: newDate!, requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
        }
        TimeModel.pauseTime = ""
        TimeModel.currentState = TimerState.Running.rawValue
        delegate?.currentTimerState(currentState: TimerState.Running)
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let startTime = CustomDateFormatter.getDateFromString(strDate: TimeModel.startTime, requiredDateFormat: "yyyy-MM-dd HH:mm:ss")
            let differenceDate = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: Date())
            self.delegate?.timerUpdate(currentTime:"\(differenceDate.hour!) : \(differenceDate.minute!) : \(differenceDate.second!)")
        }
    }

}
