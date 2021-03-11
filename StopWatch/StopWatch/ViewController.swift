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
            // Timer.scheduledTimer는 현재 RunLoop에 기본모드로 예약을하며 타이머를 생성하는 메소드이다.
            // 그러므로 현재 RunLoop에 따로 add해주지 않아도 정상 작동한다.
            // 타이머는 정수값인 timeInterval초마다 반복되며 울리며(fire) target에게 selector 메세지를 전달한다. invalitdate되기 전까지 타이머는 target과 강한 참조관계를 유지한다.
            mainStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
//            RunLoop.current.add(mainStopwatch.timer, forMode: RunLoop.Mode.common)
//            RunLoop.current.add(lapStopwatch.timer, forMode: RunLoop.Mode.common)
            
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
    // @objc 해당 심볼을 Objective-C의 네임스페이스에 알려주는 키워드이다.
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

/* Selector는 본래 Objecive-C에서 클래스 메소드의 이름을 가르키는 데 사용되는 참조 타입입니다.
동적 호출 등의 목적으로 @selector() 어트리뷰트 메소드 이름을 인자값으로 넣어 전달하면 이를 내부적으로 정수값으로 매핑해서 처리하는 형태입니다. 이것이 Swift로 넘어오면서 구조체 형식으로 정의되고, #selector()구문을 사용하여 해당 타입의 값을 생성할 수 있게 되었습니다.*/

/* Swift4부터는 Selector 타입으로 전달할 메소드를 작성할 때 반드시 @objc 어트리뷰트를 붙여주어야 합니다. 이는 Objective-C와의 호환성을 위한 것으로, Swift에서 정의한 메소드를 Objective-C에서도 인식할 수 있게 해 줍니다. */

fileprivate extension Selector {
    // #selector 함수의 매개변수로 다른함수를 참조할 때 사용하는 키워드, 함수를 참조하는 Type이다.
    // objective - C 로 작성된 부분을 참조할 때도 사용된다.
  static let updateMainTimer = #selector(ViewController.updateMainTimer)
  static let updateLapTimer = #selector(ViewController.updateLapTimer)
}

