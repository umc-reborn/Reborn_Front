//
//  TimerTestViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/10.
//

import UIKit
import CoreData

class TimerTestViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var secondsLeft: Int = 0
    var timer: Timer?
    var timer2: Timer? = nil
    var isTimerOn = false
    
    var seconds: Int = 0
    var minutes: Int = 0
    
    var container: NSPersistentContainer!
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var startStopButton: UIButton!
    
    var timeSecond = 10 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            timeLabel.text = "\(hours):\(minutes):\(seconds)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer?.invalidate()
//        setNotifications()
        secondsLeft = 30
        minutes = self.secondsLeft / 60
        seconds = self.secondsLeft % 60
        self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
//        NotificationCenter.default.addObserver(
//                    self,
//                    selector: #selector(self.startTimerNotification(_:)),
//                    name: NSNotification.Name("StartTimer"),
//                    object: nil
//        )
    }
    
//    @objc func startTimerNotification(_ notification: Notification) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
//            self.timerStart()
//        }
//    }
    
    @IBAction func startStopAction(_ sender: Any) {
        startTimer()
    }
    
//    func timerStart() {
//        if isTimerOn {
//            timer?.invalidate()
//            startStopButton.setTitle("START", for: .normal)
//        } else {
//            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//                self.fetchContacts()
//                if (self.timeSecond == 0) {
//                    timer.invalidate()
//                }
//            }
//            RunLoop.current.add(self.timer!, forMode: .common)
//            startStopButton.setTitle("STOP", for: .normal)
//        }
//        isTimerOn = !isTimerOn
//    }
//
//    func fetchContacts() {
//        do {
//            let contact = try self.container.viewContext.fetch(Entity.fetchRequest()) as! [Entity]
//           contact.forEach {
//               timeSecond = Int($0.minutes)
//          }
//        } catch {
//           print(error.localizedDescription)
//        }
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("StartTimer"), object: nil, userInfo: nil)
    }
    
    @objc func startTimer() {
        if timer != nil {
            //타이머를 리셋해주기
            self.resetTimer()
            self.startStopButton.setTitle("타이머 시작하기", for: .normal)
            //종료니까 그 뒤로 동작하면 안되므로 return 해줌
            return
          }
//
//          //타이머가 비어있을때는 타이머 시작!
//          self.startStopButton.setTitle("타이머 종료하기", for: .normal)
        //시간을 세팅
//          self.secondsLeft = 30 //180초지만 10초로 테스트

          self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            self.secondsLeft -= 1
            self.updateSecondsLabel()
              print(self.secondsLeft)
              
              
//                  let context = self.appDelegate.persistentContainer.viewContext
//                  let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
//
//                  if let entity = entity {
//                      let person = NSManagedObject(entity: entity, insertInto: context)
//
//                      person.setValue(self.secondsLeft, forKey: "seconds")
//                      do {
//                          try context.save()
//                      } catch {
//                          print(error.localizedDescription)
//                      }
//                  }
//                  self.fetchContact()
            if self.secondsLeft == 0 {
                //타이머 리셋
                self.resetTimer()
            }
          })
    }
    
//    func setNotifications() {
//            //백그라운드에서 포어그라운드로 돌아올때
//            NotificationCenter.default.addObserver(self, selector: #selector(addbackGroundTime(_:)), name: NSNotification.Name("sceneWillEnterForeground"), object: nil)
//            //포어그라운드에서 백그라운드로 갈때
//            NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
//        }
    
//    @objc func addbackGroundTime(_ notification:Notification) {
//        //노티피케이션센터를 통해 값을 받아옴
//        let time = notification.userInfo?["time"] as? Int ?? 0
//        //받아온 시간을 60으로 나눈 몫은 분
//        //            minutes += time/60
//        //            //받아온 시간을 60으로 나눈 나머지는 초
//        //            seconds += time%60
//        secondsLeft -= time
//    }
//
//    @objc func stopTimer() {
//        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
//    }

    
    func updateSecondsLabel() {
      //남은 분
      var minutes = self.secondsLeft / 60
      //그러고도 남은 초
      var seconds = self.secondsLeft % 60

      //남은 시간(초)가 0보다 크면
      if self.secondsLeft > 0 {
          self.timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
      } else {
          self.timeLabel.text = "00:00"
      }
    }
    
    func resetTimer() {
            //타이머 종료하기
        self.timer?.invalidate()
            //타이머 없애기
        self.timer = nil
            //타이머가 종료되었으므로 버튼을 '시작하기'로 바꾸기
        self.startStopButton.setTitle("타이머 시작하기", for: .normal)
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
    
    @IBAction func resetAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
