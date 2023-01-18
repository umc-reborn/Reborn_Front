//
//  AddRebornViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class AddRebornViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, SampleProtocol2{
    
    func dataSend(data: String) {
        timeLabel.text = data
        timeLabel.sizeToFit()
    }

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var eatTextfield: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var AddImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var TimeSwitch: UISwitch!
    @IBOutlet weak var countTextfield: UITextField!
    var Number = 00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimeSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        AddImageView.layer.cornerRadius = 10
        AddImageView.clipsToBounds = true
        
        countTextfield.layer.cornerRadius = 5
        countTextfield.layer.borderWidth = 1.5
        countTextfield.layer.borderColor = UIColor.gray.cgColor

        nameTextfield.layer.cornerRadius = 5
        nameTextfield.layer.borderWidth = 1
        nameTextfield.layer.borderColor = UIColor.gray.cgColor
        eatTextfield.layer.cornerRadius = 5
        eatTextfield.layer.borderWidth = 1
        eatTextfield.layer.borderColor = UIColor.gray.cgColor
        introduceTextView.layer.cornerRadius = 5
        introduceTextView.layer.borderWidth = 1
        introduceTextView.layer.borderColor = UIColor.gray.cgColor
        
        placeholderSetting()
        textViewDidBeginEditing(introduceTextView)
        textViewDidEndEditing(introduceTextView)
        nameTextfield.delegate = self
        eatTextfield.delegate = self
        textFieldDidBeginEditing(nameTextfield)
        textFieldDidEndEditing(nameTextfield)
        textFieldDidBeginEditing(eatTextfield)
        textFieldDidEndEditing(eatTextfield)
        
        countTextfield.text = String(Number)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           // textField.borderStyle = .line
        textField.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor//your color
            textField.layer.borderWidth = 1.0
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.borderWidth = 1.0
    }

    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editTimeButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TimePopupViewController") as? TimePopupViewController else { return }
        nextVC.modalPresentationStyle = .overCurrentContext
        nextVC.delegate = self
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func placeholderSetting() {
        introduceTextView.delegate = self // txtvReview가 유저가 선언한 outlet
        introduceTextView.text = " 리본을 한 줄로 소개해 주세요!"
        introduceTextView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15.0)
        introduceTextView.textColor = UIColor.systemGray
    }
        // TextView Place Holder
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.layer.borderColor = UIColor.init(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor
        }
    }
        // TextView Place Holder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " 리본을 한 줄로 소개해 주세요!"
            textView.textColor = UIColor.systemGray
        }
        textView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = introduceTextView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        countLabel.text = "\(changedText.count)/50"
        return changedText.count < 50
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
            editButton.setTitleColor(UIColor(red: 255/255, green: 251/255, blue: 249/255, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func minusCount(_ sender: Any) {
        if (Number >= 1) {
            Number -= 1
            countTextfield.text = String(Number)
        }
    }
    
    @IBAction func plusCount(_ sender: Any) {
        Number += 1
        countTextfield.text = String(Number)
    }
}
