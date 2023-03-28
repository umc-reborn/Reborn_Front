//
//  RebornCautionViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit

class RebornCautionViewController: UIViewController {
    
    var rebornId : Int = 0
    var limitTime: String = ""
    
    let rebornCaution = UserDefaults.standard.integer(forKey: "userIndex")
    
    var rebornData: CreateRebornresultModel!
    
    let DidDismissEditRebornViewController: Notification.Name = Notification.Name("DidDismissEditRebornViewController")
    
    @IBOutlet var cautionView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var TimeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("넘겨받은 값은 \(String(rebornId))")

        cautionView.layer.cornerRadius = 10
        cautionView.clipsToBounds = true
        cancelButton.layer.cornerRadius = 0
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        yesButton.layer.cornerRadius = 0
        yesButton.layer.borderWidth = 1
        
        let minuteCLimit1 = limitTime[String.Index(encodedOffset: 3)]
        let minuteCLimit2 = limitTime[String.Index(encodedOffset: 4)]
        
        TimeLabel.text = "*\(minuteCLimit1)\(minuteCLimit2)분 내 방문 필수, 이후 자동 취소"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView10"), object: nil, userInfo: nil)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView16"), object: nil, userInfo: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func yesTapped(_ sender: Any) {
        let parameterDatas = CreateRebornModel(userIdx: rebornCaution, rebornIdx: rebornId)
        APIHandlerCreateRebornPost.instance.SendingPostReborn(parameters: parameterDatas) { result in self.rebornData = result }
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
