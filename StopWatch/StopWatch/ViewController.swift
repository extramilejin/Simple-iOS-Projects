//
//  ViewController.swift
//  StopWatch
//
//  Created by 진형진 on 2021/03/02.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    fileprivate let mainStopwatch: Stopwatch = Stopwatch()
    fileprivate let lapStopwatch: Stopwatch = Stopwatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    // MARK: - UI components
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var mainTimerLabel: UILabel!
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var lapTableView: UITableView!
    
    // MARK: Actions
    @IBAction func touchUpStartStopButton(_ sender: UIButton) {
        
        changeButton(lapResetButton, "Lap", .black)
        
        if !isPlay {
            unowned let weakSelf = self
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(sender, "Stop", .red)
                
        } else {
            mainStopwatch.timer.invalidate()
            lapStopwatch.timer.invalidate()
            isPlay = false
            changeButton(sender, "Start", .green)
            changeButton(lapResetButton, "Reset", .black)
        }
    }
    
    @IBAction func touchUPLapResetButton(_ sender: UIButton) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapResetButton, "Reset", .black)
        } else {
            if let timerLabel = mainTimerLabel.text {
                laps.append(timerLabel)
            }
            lapTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil,repeats: true)
            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    // MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lapTableView.delegate = self
        lapTableView.dataSource = self
    }
    
    // MARK: - Helper
    fileprivate func changeButton (_ button: UIButton, _ buttonText: String, _ color: UIColor) {
        button.setTitle(buttonText, for: UIControl.State())
        button.setTitleColor(color, for: UIControl.State())
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopwatch, label: mainTimerLabel)
        laps.removeAll()
        lapTableView.reloadData()
    }
      
    fileprivate func resetLapTimer() {
        resetTimer(lapStopwatch, label: lapTimerLabel)
    }
      
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopwatch, label: mainTimerLabel)
    }
      
    @objc func updateLapTimer() {
        updateTimer(lapStopwatch, label: lapTimerLabel)
    }
      
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
          minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
          seconds = "0" + seconds
        }
        label.text = minutes + ":" + seconds
    }
    
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = laps.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "lapCell"
        let lapTime = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? LapTableViewCell else {
            return LapTableViewCell()
        }
        cell.lapTimeLabel.text = lapTime
        cell.lapCountLabel.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
        return cell
    }

}

// MARK: - Extension

fileprivate extension Selector {
  static let updateMainTimer = #selector(ViewController.updateMainTimer)
  static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

