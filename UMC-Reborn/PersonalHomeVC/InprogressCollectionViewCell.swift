//
//  InprogressCollectionViewCell.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/10.
//

import UIKit

protocol ComponentProductCellDelegate5 {
    func historyButtonTapped(index: Int)
}

class InprogressCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    
    @IBOutlet var exchangeBtn: UIButton!
    @IBOutlet var ongoingtime: UILabel!
    @IBOutlet var ongoingProduct: UILabel!
    @IBOutlet var ongoingCategory: UILabel!
    @IBOutlet var ongoingName: UILabel!
    @IBOutlet var ongoingImg: UIImageView!
    @IBOutlet var ongoingView: UIView!
    
    var timer: Timer? = nil
    var timeWhenGoBackground: Date?
    
    var index: Int = 0
    var delegate: ComponentProductCellDelegate5?
    
    var timeSecond = 10 {
        willSet(newValue) {
            var hours = String(newValue / 3600)
            var minutes = String(newValue / 60)
            var seconds = String(newValue % 60)
            if hours.count == 1 { hours = "0"+hours }
            if minutes.count == 1 { minutes = "0"+minutes }
            if seconds.count == 1 { seconds = "0"+seconds }
            ongoingtime.text = "\(minutes):\(seconds) 후 자동취소"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        exchangeBtn.layer.cornerRadius = 5
//        exchangeBtn.layer.borderWidth = 1
        exchangeBtn.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
//    func timerStart() {
//        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            self.timeSecond -= 1
//            if (self.timeSecond == 0) {
//                timer.invalidate()
//            }
//        }
//        RunLoop.current.add(self.timer!, forMode: .common)
//    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
            timeWhenGoBackground = Date()
            print("Save")
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
    
    @IBAction func codeButtonTapped(_ sender: Any) {
        self.delegate?.historyButtonTapped(index: index)
    }
}
