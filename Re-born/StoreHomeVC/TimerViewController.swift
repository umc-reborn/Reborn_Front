//
//  TimerViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/10.
//

import UIKit
import CoreData

class TimerViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var timeLabel: UILabel!
    
    var secondsPassed: Int = 60
    var minutesPassed: Int = 1
    var timer: Timer?
    var timer2: Timer?
    
    override func viewDidLoad() {
        timeLabel.text = "\(self.minutesPassed)분 00초"
        super.viewDidLoad()
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secondsPassed -= 1
            if self.secondsPassed == 0 {
                self.secondsPassed = 60
            }
            if self.secondsPassed == 59 {
                self.minutesPassed -= 1
            }
            DispatchQueue.main.async {
                let context = self.appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
                
                if let entity = entity {
                    let person = NSManagedObject(entity: entity, insertInto: context)
                    if self.secondsPassed == 60 {
                        person.setValue(0, forKey: "seconds")
                    } else {
                        person.setValue(self.secondsPassed, forKey: "seconds")
                    }
                    do {
                      try context.save()
                    } catch {
                      print(error.localizedDescription)
                    }
                }
                self.timeLabel.text = self.currentTimetoString(sec: self.secondsPassed, min: self.minutesPassed)
                self.fetchContact()
            }
            if ((self.minutesPassed == 0) && (self.secondsPassed == 60)) {
                self.stopTimer()
            }
        })
    }
    
    func currentTimetoString(sec: Int, min: Int) -> String {
        if sec == 60 {
            return "\(self.minutesPassed)분 00초"
        } else {
            return "\(self.minutesPassed)분 \(self.secondsPassed)초"
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.timeLabel.text = "0분 00초"
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func fetchContact() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            
        do {
            let contact = try context.fetch(Entity.fetchRequest()) as! [Entity]
           contact.forEach {
              print($0.seconds)
          }
        } catch {
           print(error.localizedDescription)
        }
    }
}
