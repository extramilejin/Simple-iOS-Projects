//
//  Stopwatch.swift
//  StopWatch
//
//  Created by 진형진 on 2021/03/03.
//

import Foundation

class Stopwatch: NSObject {
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}
