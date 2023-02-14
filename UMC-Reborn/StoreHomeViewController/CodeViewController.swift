//
//  CodeViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/28.
//

import UIKit

class CodeViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var codeTextfield: UITextField!
    @IBOutlet weak var codeokButton: UIButton!
    @IBOutlet weak var codeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeView.clipsToBounds = true
        codeView.layer.cornerRadius = 20
        codeView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)

        codeokButton.layer.cornerRadius = 5
        codeokButton.layer.borderWidth = 1.5
        codeokButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        codeTextfield.layer.cornerRadius = 5
        codeTextfield.layer.borderWidth = 1.5
        codeTextfield.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        codeTextfield.defaultTextAttributes.updateValue(16.0,
                    forKey: NSAttributedString.Key.kern)
        
        codeTextfield.delegate = self
        codeTextfield.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        codeTextfield.addTarget(self, action: #selector(textFieldInterval), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func textLimit(_ sender: Any) {
        checkMaxLength(textField: codeTextfield, maxLength: 5)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareDoneButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func textFieldEdited(textField: UITextField) {
            
        if (textField.text?.count ?? 0 == 5) {
            codeokButton.backgroundColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1)
            codeokButton.setTitleColor(.white, for: .normal)
            codeokButton.setTitleColor(.white, for: .selected)
            codeokButton.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor
        } else {
            codeokButton.backgroundColor = .white
            codeokButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .normal)
            codeokButton.setTitleColor(UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1), for: .selected)
            codeokButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        }
    }
    
    @objc func textFieldInterval(textFiled: UITextField) {
        if (codeTextfield.text == "1") {
            codeTextfield.defaultTextAttributes.updateValue(23.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "2") {
            codeTextfield.defaultTextAttributes.updateValue(16.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "4") {
            codeTextfield.defaultTextAttributes.updateValue(12.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "5") {
            codeTextfield.defaultTextAttributes.updateValue(17.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "0") {
            codeTextfield.defaultTextAttributes.updateValue(10.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "6") {
            codeTextfield.defaultTextAttributes.updateValue(14.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "7") {
            codeTextfield.defaultTextAttributes.updateValue(16.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "8") {
            codeTextfield.defaultTextAttributes.updateValue(13.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "3") {
            codeTextfield.defaultTextAttributes.updateValue(16.0, forKey: NSAttributedString.Key.kern)
        } else if (codeTextfield.text == "9") {
            codeTextfield.defaultTextAttributes.updateValue(14.0, forKey: NSAttributedString.Key.kern)
        }
    }
}
