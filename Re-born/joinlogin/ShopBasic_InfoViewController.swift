//
//  ShopBasic_InfoViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
//

import UIKit

class ShopBasic_InfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var ProfileView: UIImageView!
    @IBOutlet var CameraButton: UIButton!
    
    @IBOutlet var NameTextField: UITextField!
    @IBOutlet var NumberTextField: UITextField!
    @IBOutlet var BackgroundTextField: UITextField!
    @IBOutlet var AddressTextField: UITextField!
    @IBOutlet var IntroduceTextView: UITextView!
    
    let imagePickerController = UIImagePickerController()
    let imagePickerController2 = UIImagePickerController()
    let alertController = UIAlertController(title: "가게 프로필 사진 설정", message: "", preferredStyle: .actionSheet)
    let alertController2 = UIAlertController(title: "가게 배경 사진 설정", message: "", preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileView.layer.cornerRadius = self.ProfileView.frame.size.height / 2
        ProfileView.layer.masksToBounds = true
        ProfileView.clipsToBounds = true
        
        NameTextField.layer.cornerRadius = 5
        NameTextField.layer.borderWidth = 1
        NameTextField.layer.borderColor = UIColor.gray.cgColor
        NumberTextField.layer.cornerRadius = 5
        NumberTextField.layer.borderWidth = 1
        NumberTextField.layer.borderColor = UIColor.gray.cgColor
        BackgroundTextField.layer.cornerRadius = 5
        BackgroundTextField.layer.borderWidth = 1
        BackgroundTextField.layer.borderColor = UIColor.gray.cgColor
        AddressTextField.layer.cornerRadius = 5
        AddressTextField.layer.borderWidth = 1
        AddressTextField.layer.borderColor = UIColor.gray.cgColor
        
        IntroduceTextView.layer.cornerRadius = 5
        IntroduceTextView.layer.borderWidth = 1
        IntroduceTextView.layer.borderColor = UIColor.gray.cgColor

        textViewDidBeginEditing(IntroduceTextView)
        textViewDidEndEditing(IntroduceTextView)
        NameTextField.delegate = self
        NumberTextField.delegate = self
        BackgroundTextField.delegate = self
        AddressTextField.delegate = self
        textFieldDidBeginEditing(NameTextField)
        textFieldDidEndEditing(NameTextField)
        textFieldDidBeginEditing(NumberTextField)
        textFieldDidEndEditing(NumberTextField)
        textFieldDidBeginEditing(BackgroundTextField)
        textFieldDidEndEditing(BackgroundTextField)
        textFieldDidBeginEditing(AddressTextField)
        textFieldDidEndEditing(AddressTextField)
        
        self.imagePickerController.delegate = self
        self.imagePickerController2.delegate = self
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
    
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray {
            textView.text = nil
            textView.textColor = UIColor.black
            textView.layer.borderColor = UIColor.init(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor
        }
    }
        // TextView Place Holder
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = " 사장님의 가게를 소개해 주세요!"
            textView.textColor = UIColor.systemGray
        }
        textView.layer.borderColor = UIColor.gray.cgColor
    }

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func NextButton(_ sender: Any) {
        guard let rvc2 = self.storyboard?.instantiateViewController(withIdentifier: "InterestSecondViewController") as? InterestSecondViewController else {return}
        
        self.navigationController?.pushViewController(rvc2, animated: true)
    }
}

extension ShopBasic_InfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: false, completion: nil)
    }
    func openAlbum2() {
        self.imagePickerController2.sourceType = .photoLibrary
        present(self.imagePickerController2, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            StoreImageView?.image = image
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
//                DiaryPost.instance.uploadDiary(file: self.StoreImageView.image!, url: self.serverURL) { result in self.imageUrl = result }
//            }
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
//                self.defaultImage = self.imageUrl.result
//            }
        } else {
            print("error detected in didFinishPickinMEdiaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController2(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

        } else {
            print("error detected in didFinishPickinMEdiaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: false, completion: nil)
        } else {
            print("Camera is not available as for now")
        }
    }
    
    func openCamera2() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePickerController2.sourceType = .camera
            present(self.imagePickerController2, animated: false, completion: nil)
        } else {
            print("Camera is not available as for now")
        }
    }
}
