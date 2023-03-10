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
    var minutesPassed: Int = 3
    var timer: Timer?
    var timer2: Timer?
    
    override func viewDidLoad() {
        timeLabel.text = "\(self.minutesPassed + 1)분 00초"
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: Any) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secondsPassed -= 1
            if self.secondsPassed == 60 {
                self.secondsPassed = 0
                self.minutesPassed -= 1
            }
            DispatchQueue.main.async {
                let context = self.appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
                
                if let entity = entity {
                    let person = NSManagedObject(entity: entity, insertInto: context)
                    person.setValue(self.secondsPassed, forKey: "seconds")
                    
                    do {
                      try context.save()
                    } catch {
                      print(error.localizedDescription)
                    }
                }
                self.timeLabel.text = self.currentTimetoString(sec: self.secondsPassed, min: self.minutesPassed)
                self.fetchContact()
            }
        })
    }
    
    private func currentTimetoString(sec: Int, min: Int) -> String {
        if min > 0 {
            return "\(self.minutesPassed)분 \(self.secondsPassed)초"
        } else {
            return "\(self.secondsPassed)초"
        }
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
