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
    @IBOutlet var reviewDate: UILabel!
    @IBOutlet var storeName: UILabel!
    @IBOutlet var storeCategory: UILabel!
    @IBOutlet var backgroundView: UIView!
    
    
    var reviewStoreName: String = ""
    var reviewDates: String = ""
    var category: String = ""
    var storeImageUrl: String =  "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/44f3e518-814e-4ce1-b104-8afc86843fbd.jpg"
    
    var getProductName: String = ""
    // var get
    
    let rebornAdd = UserDefaults.standard.integer(forKey: "userIndex")
    
    // ✅ API 수정되면 값 바꾸기
    let rebornIdx = 23
    
    let serverURL = "http://www.rebornapp.shop/s3"
    
    let imagePickerController = UIImagePickerController()
    
//    let stringToNum = self().countLabel.text
//    let dd = Int(stringToNum)
    
    var stringToNum: Int = 0
    var rebornTaskIndex: Int = 0
    
    var Number = 0
    var scoreInt: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 그림자
        self.backgroundView.layer.shadowColor = UIColor.gray.cgColor //색상
                self.backgroundView.layer.shadowOpacity = 0.1 //alpha값
                self.backgroundView.layer.shadowRadius = 10 //반경
                self.backgroundView.layer.shadowOffset = CGSize(width: 0, height: 10) //위치조정
                self.backgroundView.layer.masksToBounds = false
        self.backgroundView.layer.cornerRadius = 8;
        
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
        
//         scoreInt = Int(labelText)!
        print("scoreInt is \(scoreInt)")
        
        // ======== 이미지뷰 ========
//        self.imagePickerController.delegate = self
//        addGestureRecognizer()
        
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.storeName.text = reviewStoreName
        self.storeCategory.text = category
        self.reviewDate.text = reviewDates
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
        scoreInt = intValue
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
        print("순수 label 값은 \(label!)")
        print("형변환한 label 값은 \(stringToNum)")
        

        let parmeterDatas = postReviewReqModel(userIdx: self.rebornAdd, rebornIdx: self.rebornIdx, rebornTaskIdx: self.rebornTaskIndex, reviewScore: scoreInt, reviewComment: self.textField.text ?? "", reviewImage: storeImageUrl)
        APIMyRebornHandlerPost.instance.SendingPostReview(parameters: parmeterDatas) { result in self.writeRebornData = result }
        print("리뷰작성 결과는 \(self.writeRebornData)")
//        self.presentingViewContro ller?.dismiss(animated: true, completion: nil)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "reviewManageVC") as? ReviewManageViewController else { return }
        nextVC.storeTitle = self.storeName.text!
        nextVC.storeCategory = self.storeCategory.text!
        navigationController?.pushViewController(nextVC, animated: true)
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
            AddImageView?.image = image
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                DiaryPost.instance.uploadDiary(file: self.AddImageView.image!, url: self.serverURL) { result in self.imageUrl = result }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                self.storeImageUrl = self.imageUrl.result
                print("이미지 주소 성공")
                print("\(self.storeImageUrl)")
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
