//
//  HomeInprogressViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/10.
//
import UIKit
import Foundation

class HomeInprogressViewController: UIViewController {
    
    @IBOutlet var defaultView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rebornDatas: [InprogressResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        defaultView.clipsToBounds = true
        defaultView.layer.cornerRadius = 20
        defaultView.layer.masksToBounds = false
        defaultView.layer.shadowOffset = CGSize(width: 5, height: 10)
        defaultView.layer.shadowRadius = 10
        defaultView.layer.shadowOpacity = 0.1
        
        collectionView.layer.cornerRadius = 20
        collectionView.clipsToBounds = true
        collectionView.layer.masksToBounds = false
        collectionView.layer.shadowOffset = CGSize(width: 5, height: 10)
        collectionView.layer.shadowRadius = 10
        collectionView.layer.shadowOpacity = 0.1
        
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(self.didDismissDetailNotification(_:)),
                  name: NSNotification.Name("DismissDetailView12"),
                  object: nil
                  )
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.InprogressResult()
        }
    }
    
    func InprogressResult() {
        InprogressService.shared.getInprogress { result in
            switch result {
            case .success(let response):
                //                        dump(response)
                guard let response = response as? InprogressModel else {
                    break
                }
                self.rebornDatas = response.result
                self.defaultView.isHidden = true
                self.defaultView.backgroundColor = .clear
                
                if self.rebornDatas.isEmpty {
                    self.defaultView.isHidden = false
                }
            default:
                self.defaultView.isHidden = false
                break
            }
            self.collectionView.reloadData()
            print("뭐야")
        }
    }
}

extension HomeInprogressViewController: UICollectionViewDelegate, UICollectionViewDataSource, ComponentProductCellDelegate5 {
    
    func historyButtonTapped(index: Int) {
        let rebornData = rebornDatas[index]
        let detail = UIStoryboard.init(name: "MyReborn", bundle: nil)
        guard let Checkvc = detail.instantiateViewController(identifier: "historyDetailVC") as? RebornHistoryDetailViewController else {
                    return
                }
        Checkvc.rebornTaskIdx = rebornData.rebornTaskIdx
        Checkvc.timeLimit = rebornData.productLimitTime
        navigationController?.pushViewController(Checkvc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rebornDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RebornCell", for: indexPath) as! InprogressCollectionViewCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowOpacity = 0.15
        cell.layer.shadowRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.layer.masksToBounds = false
        
        let rebornData = rebornDatas[indexPath.row]
        let url = URL(string: rebornData.productImg ?? "")
        cell.ongoingImg.load(url: url!)
        cell.ongoingName.text = rebornData.storeName
        cell.ongoingCategory.text = rebornData.category
        cell.ongoingProduct.text = rebornData.productName
        
        let timeLimit = rebornData.productLimitTime
        let hourCLimit1 = timeLimit[String.Index(encodedOffset: 0)].wholeNumberValue ?? 0
        let hourCLimit2 = timeLimit[String.Index(encodedOffset: 1)].wholeNumberValue ?? 0
        let minuteCLimit1 = timeLimit[String.Index(encodedOffset: 3)].wholeNumberValue ?? 0
        let minuteCLimit2 = timeLimit[String.Index(encodedOffset: 4)].wholeNumberValue ?? 0
        let hourTimer = 3600 * (hourCLimit1 * 10 + hourCLimit2)
        let minuteTimer = 60 * (minuteCLimit1 * 10 + minuteCLimit2)
        
        let wholeSeconds = hourTimer + minuteTimer
        cell.timeSecond = wholeSeconds
        
        cell.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            cell.timeSecond -= 1
            if (cell.timeSecond == 0) {
                timer.invalidate()
            }
        }
        RunLoop.current.add(cell.timer!, forMode: .common)
        
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RebornCell", for: indexPath) as! InprogressCollectionViewCell
        
        print("App moved to foreground")
        if let backTime = cell.timeWhenGoBackground {
            let elapsed = Date().timeIntervalSince(backTime)
            let duration = Int(elapsed)
            cell.timeSecond -= duration
            cell.timeWhenGoBackground = nil
            print("DURATION: \(duration)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RebornCell", for: indexPath) as! InprogressCollectionViewCell
        
        print("App moved to background!")
        cell.timeWhenGoBackground = Date()
        print("Save")
    }
}
extension HomeInprogressViewController: UICollectionViewDelegateFlowLayout {
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
        
    }

    // cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = 338
        let height = 165

        let size = CGSize(width: width, height: height)
        return size
    }
}
