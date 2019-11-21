//
//  FocusTimer.swift
//  BLT
//
//  Created by LorentzenN on 11/20/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import Foundation

class FocusTimer : CustomStringConvertible {
    
    var myTimer: Timer
    var mins: Int
    var secs: Int
    var description: String
    
    weak var delegate: FocusTimerDelegate?
    
    init(_ mins: Int, _ secs: Int) {
        self.mins = mins
        self.secs = secs
        myTimer = Timer()
        description = ""
    }
    
    func runTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateVals)), userInfo: nil, repeats: true)
    }
    
    func stringMe(){
        if mins > 0 {
            if secs > 9 {
                description = "\(mins):\(secs)"
            } else {
                description = "\(mins):0\(secs)"
            }
        } else if secs > 30 {
            description = "\(secs)"
        } else {
            description = "Timer Ended!"
        }
    }
    
    func stopRunning() {
        myTimer.invalidate()
        delegate?.timerEnded()
    }
    
    @objc func updateVals() {
        if secs != 0 {
            secs = secs - 1
        } else {
            if mins != 0 {
                mins = mins - 1
                secs = 59
            }
            if mins == 0 && secs == 0 {
                stopRunning()
            } else {
                secs = 59
            }
        }
        stringMe()
        delegate?.valsUpdated(description)
    }
}

protocol FocusTimerDelegate : class {
    func valsUpdated(_ timerReadout: String)
    func timerEnded()
}
