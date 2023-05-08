//
//  Basic_InfoViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/01.
// 프로필 사진, 닉네임, address, Birthday
import Foundation
import UIKit
import Alamofire

extension Basic_InfoViewController: UITextFieldDelegate {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
}

class Basic_InfoViewController: UIViewController, UITextViewDelegate, SampleProtocolS {
    
    func addressSend(data: String) {
        townTextField.text = data
        townTextField.sizeToFit()
    }
    
        
    //API
    var apple2 : String = "" // ad 광고
    var thisisemail1 : String = "" // 이메일 인증된 이메일
    
    var yourId2 : String = ""
    var yourPw2 : String = ""
    
    // 여기서 처음 보내는 것들
    var yourImage : String = ""
    var yourNickName : String = ""
    var yourGround : String = ""
//    var HBD : String = ""
    
    var defaultImage : String = ""
    
    // 프로필사진 관련 함수
    let imagePickerController = UIImagePickerController()
    let alertController = UIAlertController(title: "프로필 사진 설정", message: "", preferredStyle: .actionSheet)
    
    // image
    let serverURL = "http://www.rebornapp.shop/s3"
    
    var imageUrl: ImageresultModel! // 이미선언되어있음
    
    @IBOutlet weak var ProgressView5: UIProgressView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var BasicNextButton: UIButton!
    
    @IBOutlet var proFileView: UIImageView!
    
    @IBOutlet var cameraButton: UIButton!
    
    @IBOutlet var findAddressButton: UIButton!
    
    
    @IBOutlet var hihiview: UIView!
    
    //전역변수로 사용
    let mybrown = UIColor(named: "mybrown")
    let myorange = UIColor(named: "myorange")
    let mygray = UIColor(named: "mygray")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultImage = "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/44f3e518-814e-4ce1-b104-8afc86843fbd.jpg"

        BasicNextButton.isEnabled = false
        
        proFileView.layer.cornerRadius = self.proFileView.frame.size.height / 2
        proFileView.layer.masksToBounds = true
        proFileView.clipsToBounds = true
        
        print("Basic_InfoViewController에 광고 도착" + apple2)
        print("Basic_InfoViewController에 이메일 도착" + thisisemail1)
        print("Basic_InfoViewController에 아이디 도착" + yourId2)
        print("Basic_InfoViewController에 비밀번호 도착" + yourPw2)
        
        // back button custom
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.shadowImage = UIImage()
    
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        hihiview.backgroundColor = BACKGROUND
        self.navigationController?.navigationBar.backgroundColor = BACKGROUND
        
        //progressView5
        ProgressView5.progressViewStyle = .default
        ProgressView5.progressTintColor = .myorange
        ProgressView5.progress = 0.83
        
        // 다음버튼
        BasicNextButton.layer.borderWidth = 1.0
        BasicNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
        BasicNextButton.layer.cornerRadius = 4.0
        BasicNextButton.setTitle("다음", for: .normal)  // 버튼 텍스트 설정
        BasicNextButton.setTitleColor(UIColor.mybrown, for: .normal)//버튼 텍스트 색상 설정
        BasicNextButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo_Medium", size: 18) //폰트 및 사이즈 설정
        
        // 닉네임
        nickNameTextField.delegate = self
        textFieldDidBeginEditing(nickNameTextField)
        textFieldDidEndEditing(nickNameTextField)
        
        
        // 동네설정
        townTextField.delegate = self
        textFieldDidBeginEditing(townTextField)
        textFieldDidEndEditing(townTextField)
        
        // 생년월일
//        BDTextField.delegate = self
//        textFieldDidBeginEditing(BDTextField)
//        textFieldDidEndEditing(BDTextField)
        
        //닉네임
        nickNameTextField.addLeftPadding()
        nickNameTextField.placeholder = "띄어쓰기 없이 2~12자 이내로 입력해 주세요"
        nickNameTextField.backgroundColor = .white
        nickNameTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        

        nickNameTextField.textColor = .black
        nickNameTextField.layer.borderWidth = 1.0 // 두께
        nickNameTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        nickNameTextField.layer.cornerRadius = 4.0
        nickNameTextField.clearButtonMode = .always // 한번에 지우기
        
    
        //동네설정
        townTextField.addLeftPadding()
        townTextField.placeholder = "도로명, 지번, 건물명 검색"
        townTextField.backgroundColor = .white
        townTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        townTextField.textColor = .black
        townTextField.layer.borderWidth = 1.0 // 두께
        townTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
        townTextField.layer.cornerRadius = 4.0
//        townTextField.clearButtonMode = .always // 한번에 지우기
        
        //생년월일
//        BDTextField.addLeftPadding()
//        BDTextField.placeholder = "YYYYMMDD"
//        BDTextField.backgroundColor = .white
//        BDTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
//        BDTextField.textColor = .black
//        BDTextField.layer.borderWidth = 1.0 // 두께
//        BDTextField.layer.borderColor = mygray?.cgColor // 테두리 컬러
//        BDTextField.layer.cornerRadius = 4.0
        
        //프로필 사진
        enrollAlertEvent()
        self.imagePickerController.delegate = self
        addGestureRecognizer()
        
        
        // add target
        nickNameTextField.addTarget(self, action: #selector(AlltextFieldisFilled), for: .editingChanged)
        townTextField.addTarget(self, action: #selector(AlltextFieldisFilled), for: .editingChanged)
//        BDTextField.addTarget(self, action: #selector(AlltextFieldisFilled), for: .editingChanged)
        print(proFileView.image ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "회원가입"
    }

    //작성 중 주황색
   func textFieldDidBeginEditing(_ textField: UITextField) {
          // textField.borderStyle = .line
       textField.layer.borderColor = UIColor(red: 255/255, green: 77/255, blue: 21/255, alpha: 1).cgColor//your color
           textField.layer.borderWidth = 1.0
   }

   func textFieldDidEndEditing(_ textField: UITextField) {
           textField.layer.borderColor = UIColor.gray.cgColor
           textField.layer.borderWidth = 1.0
   }
    
    @objc func AlltextFieldisFilled(textField: UITextField){
        if ((nickNameTextField.text?.count ?? 0 >= 2) && !(townTextField.text == "") && (nickNameTextField.text?.count ?? 0 <= 12)){
            BasicNextButton.isEnabled = true
            BasicNextButton.setTitleColor(.white, for: .normal)
            BasicNextButton.layer.borderWidth = 1.0
            BasicNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
            BasicNextButton.backgroundColor = .mybrown
        }
        else {
            BasicNextButton.setTitleColor(.mybrown, for: .normal)
            BasicNextButton.layer.borderWidth = 1.0
            BasicNextButton.layer.borderColor = mybrown?.cgColor // 테두리 컬러
            BasicNextButton.backgroundColor = .white
        }
    }

    
    @IBAction func plzNextButtonTapped(_ sender: Any) {
        
        yourNickName = nickNameTextField.text ?? ""
        yourGround = townTextField.text ?? ""
        
       
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "InterestViewController") as? InterestViewController else {return}

        rvc.apple3 = apple2 // who에서 email로 온 거 담아서 보낼거임
        rvc.thisisemail2 = thisisemail1 // 이메일 담음 (보낼거야)
        rvc.yourId3 = yourId2
        rvc.yourPw3 = yourPw2
        rvc.myImg1 = defaultImage
        rvc.yourNickName1 = yourNickName
        rvc.yourGround1 = yourGround
//        rvc.HBD1 = HBD
        
        self.navigationController?.pushViewController(rvc, animated: true)
        
        
    }
    // 프로필사진 관련 함수
    func enrollAlertEvent() {
            let photoLibraryAlertAction = UIAlertAction(title: "앨범에서 사진 선택", style: .default) {
                (action) in
                self.openAlbum() // 아래에서 설명 예정.
            }
            
            let cameraAlertAction = UIAlertAction(title: "사진 촬영", style: .default) {
                (action) in
                self.openCamera() // 아래에서 설명 예정.
            }
            
            let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            self.alertController.addAction(photoLibraryAlertAction)
            self.alertController.addAction(cameraAlertAction)
            self.alertController.addAction(cancelAlertAction)
            guard let alertControllerPopoverPresentationController = alertController.popoverPresentationController
            else {return}
            prepareForPopoverPresentation(alertControllerPopoverPresentationController)
        }
    
    
    // 프로필사진 관련 함수
    func addGestureRecognizer() {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedUIImageView(_gesture:)))
            self.cameraButton.addGestureRecognizer(tapGestureRecognizer)
            self.cameraButton.isUserInteractionEnabled = true
        }
    
    // 프로필사진 관련 함수
    @objc func tappedUIImageView(_gesture: UITapGestureRecognizer) {
            self.present(alertController, animated: true, completion: nil)
        }
}
// 프로필사진
extension Basic_InfoViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        if let popoverPresentationController = self.alertController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

// 프로필사진
extension Basic_InfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openAlbum() {
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            proFileView?.image = image
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                DiaryPost.instance.uploadDiary(file: self.proFileView.image!, url: self.serverURL) { result in self.imageUrl = result }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                self.defaultImage = self.imageUrl.result
            }
        } else {
            print("error detected in didFinishPickinMEdiaWithInfo method")
        }
        dismiss(animated: true, completion: nil)
    }
    //프로필 사진
    func openCamera() {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            self.imagePickerController.sourceType = .camera
            present(self.imagePickerController, animated: false, completion: nil)
        } else {
            print("Camera is not available as for now")
        }
    }
    
    //address
    @IBAction func findAddressButton(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(identifier: "myAdressViewController") as? myAdressViewController else {
                    return
                }
        rvc.delegate = self
        
        self.present(rvc, animated: true)
    }
    
    class DiaryPost {
        static let instance = DiaryPost()
        
        func uploadDiary(file: UIImage, url: String, handler: @escaping (_ result: ImageresultModel)->(Void)) {
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
                        
                        let jsonresult = try JSONDecoder().decode(ImageresultModel.self, from: data!)
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
