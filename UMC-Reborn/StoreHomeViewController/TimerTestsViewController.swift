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
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
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
            timerLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    
        timeSecond = 20
        timeSecond2 = 30
//        fetchContact()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isTimerOn {
            timeWhenGoBackground = Date()
            print("Save")
        }
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
    
    @IBAction func timeBtnClicked(_ sender: Any) {
        if isTimerOn {
            timer?.invalidate()
            timeButton.setTitle("START", for: .normal)
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Entity", in: self.container.viewContext)
            let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.timeSecond -= 1
                person.setValue(self.timeSecond, forKey: "minutes")
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
        guard let svc5 = self.storyboard?.instantiateViewController(identifier: "TimerViewController") as? TimerViewController else {
                    return
                }
        self.navigationController?.pushViewController(svc5, animated: true)
        print("ㄱㅈㄱㅈ")
    }
    
    func fetchContact() {
        do {
            let contact = try self.container.viewContext.fetch(Entity.fetchRequest()) as! [Entity]
           contact.forEach {
            self.timeLabel2.text = "\($0.minutes)"
          }
        } catch {
           print(error.localizedDescription)
        }
    }
}
