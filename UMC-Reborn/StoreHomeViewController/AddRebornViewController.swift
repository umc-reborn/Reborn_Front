//
//  AddRebornViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class AddRebornViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var eatTextfield: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var AddImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddImageView.layer.cornerRadius = 10
        AddImageView.clipsToBounds = true

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

    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
