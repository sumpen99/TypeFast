//
//  Counter.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-23.
//

import Foundation

class Counter{
    
    private let step: Double
    private var timer: Timer?
    private var isPaused: Bool = false
    var isCounting: Bool { return timer != nil }
    private(set) var current: Double = 0.0
    private(set) var from: Double?
    private(set) var to: Double?
    
    private var timeIntervalTimelapsFrom: TimeInterval?
    private var timerSavedTime: TimeInterval = 0
    
    typealias TimeUpdated = (_ time: Double)->Void
    let timeUpdated: TimeUpdated
    
    init(to: Double,from: Double,step: Double = 1.0,timeUpdated: @escaping TimeUpdated){
        self.to = to
        self.from = from
        self.current = from
        self.step = step
        self.timeUpdated = timeUpdated
    }
    
    deinit{
        printAny("deinit clock")
        deinitTimer()
    }
    
    func toggle(){
        guard timer != nil else{
            initTimer()
            return
        }
        deinitTimer()
    }
    
    func resume() -> Bool{
        if isPaused{
            toggle()
            isPaused = false
            return true
        }
        return false
    }
    
    func paus(){
        guard timer != nil else{
            return
        }
        deinitTimer()
        isPaused = true
    }
    
    func stop(){
        deinitTimer()
        from = nil
        to = nil
    }
    
    private func initTimer(){
        let action: (Timer)->Void = { [weak self] timer in
            guard let strongSelf = self else { return }
            strongSelf.current -= strongSelf.step
            strongSelf.timeUpdated(round(strongSelf.current))
        }
        timer = Timer.scheduledTimer(withTimeInterval: step,
                                     repeats: true,
                                     block: action)
    }
    
    private func deinitTimer(){
        timer?.invalidate()
        timer = nil
    }
}
