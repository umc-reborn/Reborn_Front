//
//  EditRebornViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

class EditRebornViewController: UIViewController {

    @IBOutlet weak var EditImageView: UIImageView!
    @IBOutlet weak var TimeSwitch: UISwitch!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countTextfield: UITextField!
    var Number = 00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimeSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)

        EditImageView.layer.cornerRadius = 10
        EditImageView.clipsToBounds = true
        
        countTextfield.layer.cornerRadius = 5
        countTextfield.layer.borderWidth = 1.5
        countTextfield.layer.borderColor = UIColor.gray.cgColor
        
        countTextfield.text = String(Number)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func EdittimeButton(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "StoreTab", bundle: nil)
            let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupViewController")
            popupVC.modalPresentationStyle = .overCurrentContext
            present(popupVC, animated: true, completion: nil)
    }
    
    
    @IBAction func textSwitch(_ sender: Any) {
        if(TimeSwitch.isOn) {
            timeLabel.text = "00 시간 00 분"
            editButton.layer.cornerRadius = 5
            editButton.layer.borderWidth = 1
            editButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
            editButton.backgroundColor = UIColor.white
            editButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
        } else {
            timeLabel.text = "           "
            editButton.layer.borderColor = UIColor(red: 255/255, green: 251/255, blue: 249/255, alpha: 1).cgColor
            editButton.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 249/255, alpha: 1)
            editButton.titleLabel?.textColor = UIColor(red: 255/255, green: 251/255, blue: 249/255, alpha: 1)
        }
    }
    
    @IBAction func minusCount(_ sender: Any) {
        Number -= 1
        countTextfield.text = String(Number)
    }
    
    @IBAction func addCount(_ sender: Any) {
        Number += 1
        countTextfield.text = String(Number)
    }
}
