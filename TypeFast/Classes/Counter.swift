//
//  Counter.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-23.
//

import Foundation

protocol CounterDelegate{
    func counterHasFinished(timeElapsed: Double)
}

class Counter{
    
    private let step: Double
    private var timer: Timer?
    
    private(set) var current: Double = 0.0
    private(set) var from: Double?
    private(set) var to: Double?
    
    private var timeIntervalTimelapsFrom: TimeInterval?
    private var timerSavedTime: TimeInterval = 0
    
    typealias TimeUpdated = (_ time: Double)->Void
    let timeUpdated: TimeUpdated
    
    var isPaused:Bool{
        return timer == nil
    }
    
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
    
    func stop(){
        printAny("stop clock")
        deinitTimer()
        from = nil
        to = nil
        timerSavedTime = 0
        //timeUpdated(0)
    }
    
    private func initTimer(){
        let action: (Timer)->Void = { [weak self] timer in
            guard let strongSelf = self
            else { return }
            
            //let to = Date().timeIntervalSince1970
            //let timeIntervalFrom = strongSelf.timeIntervalTimelapsFrom ?? to
            //let time = strongSelf.timerSavedTime + (to - timeIntervalFrom)
            strongSelf.current -= strongSelf.step
            strongSelf.timeUpdated(round(strongSelf.current))
        }
        
        /*if from == nil {
            from = Date()
        }
        if timeIntervalTimelapsFrom == nil {
            timeIntervalTimelapsFrom = Date().timeIntervalSince1970
        }*/
        
        timer = Timer.scheduledTimer(withTimeInterval: step,
                                     repeats: true,
                                     block: action)
    }
    
    private func deinitTimer(){
        /*if let timeIntervalTimelapsFrom = timeIntervalTimelapsFrom {
            let to = Date().timeIntervalSince1970
            timerSavedTime += to - timeIntervalTimelapsFrom
        }*/
        
        timer?.invalidate()
        timer = nil
        //timeIntervalTimelapsFrom = nil
    }
}
