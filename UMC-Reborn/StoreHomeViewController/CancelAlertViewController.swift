//
//  CancelAlertViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/03/09.
//

import UIKit

class CancelAlertViewController: UIViewController {

    var rebornTaskId : Int = 0
    
    var rebornData: RebornCancelresultModel!
    
    let DidDismissEditRebornViewController: Notification.Name = Notification.Name("DidDismissEditRebornViewController")
    
    @IBOutlet var cancelView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("넘겨받은 값은 \(String(rebornTaskId))")

        cancelView.layer.cornerRadius = 10
        cancelView.clipsToBounds = true
        cancelButton.layer.cornerRadius = 0
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        yesButton.layer.cornerRadius = 0
        yesButton.layer.borderWidth = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("DismissDetailView9"), object: nil, userInfo: nil)
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareCancelButton(_ sender: Any) {
        let parameterDatas = RebornCancelModel(rebornTaskIdx: rebornTaskId)
        APIHandlerCancelPost.instance.SendingPostReborn(rebornTaskId: rebornTaskId, parameters: parameterDatas) { result in self.rebornData = result }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
