//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Chaman Sharma on 12/07/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var stackView : UIStackView?
    @IBOutlet var startButton : UIButton?
    @IBOutlet var pauseButton : UIButton?
    @IBOutlet var stopResetButton : UIButton?
    @IBOutlet var timeLabel : UILabel?
    var timerViewModel = TimerViewModel()
    @IBOutlet var stackWidth : NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        timerViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timerViewModel.checkPreviousState()
    }
    
    @IBAction func timerStartAction( ) {
        timerViewModel.timerStartAction()
    }
    
    @IBAction func timerStopResetAction() {
        timerViewModel.timerStopResetAction()
    }
    
    @IBAction func timerPauseResumeAction() {
        if pauseButton?.title(for: UIControl.State.normal) == "PAUSE" {
            timerViewModel.timerPauseAction()
        } else {
            timerViewModel.timerResumeAction()
        }
    }
}

//Deletgates Methods of Timer ViewModel
extension ViewController : TimerProtocol {
    //Handing the all state of Timer
    func currentTimerState(currentState: TimerState) {
        if currentState == TimerState.Running {
            pauseButton?.isHidden = false
            stopResetButton?.isHidden = false
            startButton?.isHidden = true
            stackWidth?.constant = 225
            pauseButton?.setTitle("PAUSE", for: UIControl.State.normal)
        } else if currentState == TimerState.Stop {
            pauseButton?.isHidden = true
            stopResetButton?.isHidden = true
            startButton?.isHidden = false
            stackWidth?.constant = 110
        } else if currentState == TimerState.Pause {
            pauseButton?.isHidden = false
            stopResetButton?.isHidden = false
            startButton?.isHidden = true
            stackWidth?.constant = 225
            pauseButton?.setTitle("RESUME", for: UIControl.State.normal)
        }
    }
    
    //It is for updating the timer in every second.
    func timerUpdate(currentTime: String) {
        timeLabel?.text = currentTime
    }

}

