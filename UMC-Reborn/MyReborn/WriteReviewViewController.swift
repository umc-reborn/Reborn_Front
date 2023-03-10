//
//  WriteReviewViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/23.
//

import UIKit
import Alamofire

class WriteReviewViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var imageUrl: ReviewImageresultModel!
    var writeRebornData:[postReviewReqResultModel]!

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet var AddImageView: UIImageView!

    let rebornAdd = UserDefaults.standard.integer(forKey: "userIndex")
    
    let rebornIdx = 23
    
    let serverURL = "http://www.rebornapp.shop/s3"
    
    let imagePickerController = UIImagePickerController()
    
//    let stringToNum = self().countLabel.text
//    let dd = Int(stringToNum)
    
    lazy var stringToNum = UInt(label.text ?? "")
    
    var Number = 0
    var scoreInt: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("rebornIdx값은 \(rebornIdx)")
        
        self.navigationController?.navigationBar.topItem?.title = ""

        // ======== 상세 리뷰 작성 textField ========
        self.textField.layer.borderWidth = 1.0
        self.textField.layer.borderColor=UIColor.lightGray.cgColor
        self.textField.text = ""
        self.textField.textColor=UIColor.black
        self.textField.returnKeyType = .done
        self.textField.delegate = self
        self.textField.textContainer.lineFragmentPadding = 8
        self.textField.layer.cornerRadius = 8
        
        let labelText: String = self.label.text!
        
         scoreInt = Int(labelText)
        
        // ======== 이미지뷰 ========
//        self.imagePickerController.delegate = self
//        addGestureRecognizer()
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        countLabel.text! = "\(changedText.count)/500"
        return true
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func onDragStarSlider(_ sender: UISlider) {
        let floatValue = floor(sender.value * 5) / 5
                let intValue = Int(floor(sender.value))

                for index in 1...5 { // 여기서 index는 우리가 설정한 'Tag'로 매치시킬 것이다.
                    if let starImage = view.viewWithTag(index) as? UIImageView {
                        if index <= intValue {
                            starImage.image = UIImage(named: "full_star")
                            } else {
                                starImage.image = UIImage(named: "empty_star")
                            }
                        }
                    }
                    self.label?.text = String(Int(floatValue))
                }
    
    @IBAction func addReviewButton(_ sender: Any) {
        print("순수 label 값은 \(label!)")
        print("형변환한 label 값은 \(stringToNum!)")
    }
    
//    func addGestureRecognizer() {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedUIImageView(_gesture:)))
//        self.AddImageView.addGestureRecognizer(tapGestureRecognizer)
//        self.AddImageView.isUserInteractionEnabled = true
//    }
//
//    @objc func tappedUIImageView(_gesture: UITapGestureRecognizer) {
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    @IBAction func postReviewButton(_ sender: UIButton) {
        
        // TODO: rebornIdx 수정 필요

        let parmeterDatas = postReviewReqModel(userIdx: self.rebornAdd, rebornIdx: self.rebornIdx, reviewScore: scoreInt, reviewComment: self.textField.text ?? "", reviewImage: self.imageUrl.result ?? "")
        APIMyRebornHandlerPost.instance.SendingPostReview(parameters: parmeterDatas) { result in self.writeRebornData = result }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddImageUrl(_ sender: UIButton) {
        DiaryPost.instance.uploadDiary(file: self.AddImageView.image!, url: self.serverURL) { result in self.imageUrl = result }
    }
    
    @IBAction func pressedAddButton(_ sender: Any) {
        self.imagePickerController.delegate = self
               self.imagePickerController.sourceType = .photoLibrary
               present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            AddImageView.image = image
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                DiaryPost.instance.uploadDiary(file: self.AddImageView.image!, url: self.serverURL) { result in self.imageUrl = result }
            }
        }
        
        picker.dismiss(animated: true, completion: nil) //dismiss를 직접 해야함
    }
    
    
    
    class DiaryPost {
        static let instance = DiaryPost()
        
        func uploadDiary(file: UIImage, url: String, handler: @escaping (_ result: ReviewImageresultModel)->(Void)) {
            let headers: HTTPHeaders = [
                                "Content-type": "multipart/form-data"
                            ]
            AF.upload(multipartFormData: { (multipart) in
                if let imageData = file.jpegData(compressionQuality: 0.8) {
                    multipart.append(imageData, withName: "file", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
            }, to: url ,method: .post ,headers: headers).response { responce in
                switch responce.result {
                case .success(let data):
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed)
                        print(json)
                        
                        let jsonresult = try JSONDecoder().decode(ReviewImageresultModel.self, from: data!)
                        handler(jsonresult)
                        print(jsonresult)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
