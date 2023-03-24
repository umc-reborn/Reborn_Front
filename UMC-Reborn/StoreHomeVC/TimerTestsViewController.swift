//
//  TimerTestsViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/14.
//

import UIKit
import CoreData

class TimerTestsViewController: UIViewController {
    
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var timeButton: UIButton!
    @IBOutlet var timeLabel2: UILabel!
    
    var container: NSPersistentContainer!
    var timer: Timer? = nil
    var isTimerOn = false
    var timeWhenGoBackground: Date?
    var timeSecond = 10 {
        willSet(newValue) {
            var hours = newValue / 3600
            var minutes = (newValue % 3600) / 60
            var seconds = (newValue % 3600) % 60
            if ((hours < 10) && (minutes < 10) && (seconds < 10)) {
                timerLabel.text = "0\(hours):0\(minutes):0\(seconds)"
            } else if ((hours < 10) && (minutes >= 10) && (seconds >= 10)) {
                timerLabel.text = "0\(hours):\(minutes):\(seconds)"
            } else if ((hours >= 10) && (minutes < 10) && (seconds >= 10)) {
                timerLabel.text = "\(hours):0\(minutes):\(seconds)"
            } else if ((hours >= 10) && (minutes >= 10) && (seconds < 10)) {
                timerLabel.text = "\(hours):\(minutes):0\(seconds)"
            } else if ((hours < 10) && (minutes < 10) && (seconds >= 10)) {
                timerLabel.text = "0\(hours):0\(minutes):\(seconds)"
            } else if ((hours < 10) && (minutes >= 10) && (seconds < 10)) {
                timerLabel.text = "0\(hours):\(minutes):0\(seconds)"
            } else if ((hours >= 10) && (minutes < 10) && (seconds < 10)) {
                timerLabel.text = "\(hours):0\(minutes):0\(seconds)"
            }
        }
    }
    
    var timeSecond2 = 10 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timeLabel2.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func printSecondsToHoursMinutesSeconds (seconds:Int) -> () {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        timerLabel.text = "\(h):\(m):\(s)"
      print ("\(h) Hours, \(m) Minutes, \(s) Seconds")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    
        timeSecond = 6731

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(
                            self,
                            selector: #selector(self.startTimerNotification(_:)),
                            name: NSNotification.Name("StartTimer"),
                            object: nil
                )
    }
    
        @objc func startTimerNotification(_ notification: Notification) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                self.timerStart()
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        appMovedToForeground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appMovedToBackground()
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
//        if isTimerOn {
            timeWhenGoBackground = Date()
            print("Save")
//        }
    }

    @objc func appMovedToForeground() {
        print("App moved to foreground")
        if let backTime = timeWhenGoBackground {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            timeSecond -= duration
            timeWhenGoBackground = nil
            print("DURATION: \(duration)")
        }
    }

    func timerStart() {
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: self.container.viewContext)
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeSecond -= 1
            person.setValue(self.timeSecond, forKey: "seconds")
            do {
                try self.container.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
            if (self.timeSecond == 0) {
                timer.invalidate()
            }
            self.fetchContact()
        }
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    @IBAction func timeBtnClicked(_ sender: Any) {
        if isTimerOn {
            timer?.invalidate()
            timeButton.setTitle("START", for: .normal)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Entity", in: self.container.viewContext)
            let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timeSecond -= 1
                person.setValue(self.timeSecond, forKey: "seconds")
                do {
                    try self.container.viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
                if (self.timeSecond == 0) {
                    timer.invalidate()
                }
                self.fetchContact()
            }
            RunLoop.current.add(self.timer!, forMode: .common)
            timeButton.setTitle("STOP", for: .normal)
        }
        isTimerOn = !isTimerOn
    }
    
    @IBAction func nextButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TimerTestViewController") as? TimerTestViewController else { return }
        self.present(nextVC, animated: false, completion: nil)
    }
    
    @IBAction func nextButton2(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TimerViewController") as? TimerViewController else { return }
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func fetchContact() {
        do {
            let contact = try self.container.viewContext.fetch(Entity.fetchRequest()) as! [Entity]
           contact.forEach {
            print("\($0.seconds)")
               timeSecond2 = Int($0.seconds)
//            self.timeLabel2.text = "\($0.seconds)"
          }
        } catch {
           print(error.localizedDescription)
        }
    }
}
