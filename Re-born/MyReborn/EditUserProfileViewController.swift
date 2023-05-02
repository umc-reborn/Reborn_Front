//
//  EditUserProfileViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/18.
//

import UIKit
import Alamofire

class EditUserProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, MySampleProtocol, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let userJWT = UserDefaults.standard.string(forKey: "userJwt")!

    var selectCategory: String = ""
    var storeImageUrl: String =  "https://rebornbucket.s3.ap-northeast-2.amazonaws.com/44f3e518-814e-4ce1-b104-8afc86843fbd.jpg"

    let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 28))
    let button2 = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 28))
    let button3 = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 28))
    let button4 = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 28))
    let button5 = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 28))

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var EditNicknameTextField: UITextField!
    @IBOutlet var EditAddressTextField: UITextField!
    
    @IBOutlet var userProfileImage: UIImageView!
    
    let serverURL = "http://www.rebornapp.shop/s3"
    
    let imagePickerController = UIImagePickerController()
    
    var imageUrl: ReviewImageresultModel!
    var rebornData: EditUserInfoResultModel!
    
    
    // 스크롤뷰 추가
    private let contentScrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.backgroundColor = .white
            scrollView.showsVerticalScrollIndicator = false
            
            return scrollView
        }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //
    func addSubview() {
      self.view.addSubview(contentScrollView)
        contentScrollView.addSubview(button1)
        contentScrollView.addSubview(button2)
        contentScrollView.addSubview(button3)
        contentScrollView.addSubview(button4)
        contentScrollView.addSubview(button5)
    }
    //
    private func setUpUIConstraints() {
      NSLayoutConstraint.activate([
                contentScrollView.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor),
                contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                contentScrollView.bottomAnchor.constraint(equalTo: self.self.categoryLabel.bottomAnchor),
                contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
                            contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
                            contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
                            contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
                contentView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor)
    ])
    }
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // =========================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
    

    @objc func FinishEditMode() {
        print("버튼 테스트")
        // 📌 API 수정되면 img URL 변경
        
        isSelectedCategory()
        let parameterDatas = EditUserInfoModel(userImg: storeImageUrl, userNickname: EditNicknameTextField.text ?? "", userAddress: EditAddressTextField.text ?? "", userLikes: selectCategory ?? "")
        APIHandlerUserInfoPost.instance.SendingPostReborn(token: userJWT, parameters: parameterDatas) { result in self.rebornData = result }
        print("회원정보수정 결과는 \(self.rebornData)")
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MyRebornVC") as? MyRebornViewController else { return }
        nextVC.getUserName = EditNicknameTextField.text ?? ""
        navigationController?.pushViewController(nextVC, animated: true)

        print("post된 카테고리는 \(self.selectCategory)")
    }
    
    func addressSend(data: String) {
        EditAddressTextField.text = data
        EditAddressTextField.sizeToFit()
        print(data)
    }
    
// 하나만 선택되게
// 변수에 선택된 값 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.isSelectedCategory()
        }
        UserInfoResult()
        
        createButton1()
        createButton2()
        createButton3()
        createButton4()
        createButton5()
        
        
        
        userProfileImage.layer.cornerRadius = self.userProfileImage.frame.size.height / 2
        userProfileImage.layer.masksToBounds = true
        userProfileImage.clipsToBounds = true
        
        if button1.isSelected {
            // 1. 저장을 위한 변수 선언(맨 위에)
            // 2. 버튼을 클릭했을 때 1번 변수에 저장(sender.label.text)
            // 3. 클릭했을 때 UI
            // 4. 다른 거를 선택했을 땐 for문을 써서 나머지 버튼 색깔들을 뺌
        }

        // 닉네임 값 변경
//        guard let name = nickname else {return}
//        self.EditNicknameTextField.text = "ㅎ"

        // 네비게이션 바
        self.navigationItem.title = "회원정보 수정"
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(FinishEditMode))
        self.navigationItem.rightBarButtonItem?.tintColor = .init(named: "MainColor")
        
        // 텍스트 필드
        EditNicknameTextField.delegate = self
        EditAddressTextField.delegate = self
//        EditBirthTextField.delegate = self
        
        EditNicknameTextField.addLeftPadding()
        EditAddressTextField.addLeftPadding()
//        EditㅓㅇTextField.addLeftPadding()
        
        EditNicknameTextField.layer.borderWidth = 1.0
        EditNicknameTextField.layer.cornerRadius = 4
        EditNicknameTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        EditAddressTextField.layer.borderWidth = 1.0
        EditAddressTextField.layer.cornerRadius = 4
        EditAddressTextField.layer.borderColor = UIColor.darkGray.cgColor
        
//        EditBirthTextField.layer.borderWidth = 1.0
//        EditBirthTextField.layer.cornerRadius = 4
//        EditBirthTextField.layer.borderColor = UIColor.darkGray.cgColor
        
        // 텍스트 필드 컬러
        textFieldDidBeginEditing(EditNicknameTextField)
        textFieldDidBeginEditing(EditAddressTextField)
//        textFieldDidBeginEditing(EditBirthTextField)
        
        textFieldDidEndEditing(EditNicknameTextField)
        textFieldDidEndEditing(EditAddressTextField)
//        textFieldDidEndEditing(EditBirthTextField)
        
        self.imagePickerController.delegate = self
        
        // 생년월일 특정 문자열만 가져오기
//        let userBirth = EditAddressTextField.text ?? ""
//        print("userBirth count is \(userBirth.count)")
//        let startIndex = userBirth.index(userBirth.startIndex, offsetBy: 0)// 사용자지정 시작인덱스
//        let endIndex = userBirth.index(userBirth.startIndex, offsetBy:10)
        
        
        
        //
        
        
    }
    
    func UserInfoResult() {
        
        let url = "http://www.rebornapp.shop/users/inform"
        
        let encodedStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedStr) else { print("err"); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        

        
        print("응답하라 \(userJWT)")
        
        // Header
        request.addValue("\(userJWT)", forHTTPHeaderField: "X-ACCESS-TOKEN")
        
        
        URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if error != nil {
                print("err")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~=
            response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let safeData = data {
                print(String(decoding: safeData, as: UTF8.self))
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(UserList.self, from: safeData)
                    let storeDatas = decodedData.result
                    print(storeDatas)
                    DispatchQueue.main.async {
                        let url = URL(string: storeDatas.userImg ?? "")
                        self.userProfileImage.load(url: url!)
                        self.storeImageUrl = storeDatas.userImg!
                        self.EditNicknameTextField.text = storeDatas.userNickname
//                        self.EditBirthTextField.text = storeDatas.userBirthDate
                        self.EditAddressTextField.text = storeDatas.userAddress
                        // userLikes
                        self.selectCategory = storeDatas.userLikes
                        print("데이타 \(storeDatas)")
                        print("selectCategory is \(self.selectCategory)")
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    // 카테고리 버튼1
    func createButton1() {
        button1.configuration = createConfig()
        view.addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button1.leadingAnchor.constraint(equalTo: self.categoryLabel.leadingAnchor, constant: 0).isActive = true
        
        button1.changesSelectionAsPrimaryAction = true

        button1.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "카페·디저트"
            config?.baseBackgroundColor = button.isSelected && button.changesSelectionAsPrimaryAction ? .init(named: "lightred") : .white
          config?.image = button.isSelected && button.changesSelectionAsPrimaryAction
          ? UIImage(named: "checkedicon")
            : .none
            var arr = AttributedString.init("카페·디저트")
            arr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config?.attributedTitle = arr
          button.configuration = config
            
            if self.button1.isSelected {
                self.selectCategory = "CAFE"
            }
            self.button2.isSelected = false
            self.button3.isSelected = false
            self.button4.isSelected = false
            self.button5.isSelected = false
        }
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.cornerRadius = 16
    }
    
    func createConfig() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button1")
        titleAttr.font = .systemFont(ofSize: 9.0, weight: .regular)
            config.attributedTitle = titleAttr
        config.titlePadding = 2
        return config
    }
    
    // 카테고리 버튼2
    func createButton2() {
        button2.configuration = createConfig2()
        view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button2.leadingAnchor.constraint(equalTo: self.button1.trailingAnchor, constant: 4).isActive = true
        
        button2.changesSelectionAsPrimaryAction = true

        button2.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "편의·생활"
            config?.baseBackgroundColor = button.isSelected && button.changesSelectionAsPrimaryAction ? .init(named: "lightred") : .white
          config?.image = button.isSelected && button.changesSelectionAsPrimaryAction
          ? UIImage(named: "checkedicon")
            : .none
            var arr = AttributedString.init("편의·생활")
            arr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config?.attributedTitle = arr
          button.configuration = config
            if self.button2.isSelected {
                self.selectCategory = "LIFE"
            }
            self.button1.isSelected = false
            self.button3.isSelected = false
            self.button4.isSelected = false
            self.button5.isSelected = false
        }
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.cornerRadius = 16
    }
    
    func createConfig2() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button2")
        titleAttr.font = .systemFont(ofSize: 11.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼3
    func createButton3() {
        button3.configuration = createConfig3()
        view.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button3.leadingAnchor.constraint(equalTo: self.button2.trailingAnchor, constant: 4).isActive = true
        
        button3.changesSelectionAsPrimaryAction = true

        button3.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "반찬"
            config?.baseBackgroundColor = button.isSelected && button.changesSelectionAsPrimaryAction ? .init(named: "lightred") : .white
          config?.image = button.isSelected && button.changesSelectionAsPrimaryAction
          ? UIImage(named: "checkedicon")
            : .none
            var arr = AttributedString.init("반찬")
            arr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config?.attributedTitle = arr
          button.configuration = config
            if self.button3.isSelected {
                self.selectCategory = "SIDEDISH"
            }
            self.button1.isSelected = false
            self.button2.isSelected = false
            self.button4.isSelected = false
            self.button5.isSelected = false
        }
        
        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.cornerRadius = 16
    }
    
    func createConfig3() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button3")
        titleAttr.font = .systemFont(ofSize: 11.0, weight: .regular)
        config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼4
    func createButton4() {
        button4.configuration = createConfig4()
        view.addSubview(button4)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button4.leadingAnchor.constraint(equalTo: self.button3.trailingAnchor, constant: 4).isActive = true
        
        button4.changesSelectionAsPrimaryAction = true

        button4.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "패션"
            config?.baseBackgroundColor = button.isSelected && button.changesSelectionAsPrimaryAction ? .init(named: "lightred") : .white
          config?.image = button.isSelected && button.changesSelectionAsPrimaryAction
          ? UIImage(named: "checkedicon")
            : .none
            var arr = AttributedString.init("패션")
            arr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config?.attributedTitle = arr
          button.configuration = config
            if self.button4.isSelected {
                self.selectCategory = "FASHION"
            }
            self.button1.isSelected = false
            self.button2.isSelected = false
            self.button3.isSelected = false
            self.button5.isSelected = false
        }
        
        button4.layer.borderWidth = 1
        button4.layer.borderColor = UIColor.lightGray.cgColor
        button4.layer.cornerRadius = 16
    }
    
    func createConfig4() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button4")
        titleAttr.font = .systemFont(ofSize: 11.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
    }
    
    // 카테고리 버튼5
    func createButton5() {
        button5.configuration = createConfig5()
        view.addSubview(button5)
        button5.translatesAutoresizingMaskIntoConstraints = false
        button5.topAnchor.constraint(equalTo: self.categoryLabel.bottomAnchor, constant: 24).isActive = true
        button5.leadingAnchor.constraint(equalTo: self.button4.trailingAnchor, constant: 4).isActive = true
        
        button5.changesSelectionAsPrimaryAction = true

        button5.configurationUpdateHandler =  { button in
          var config = button.configuration
          config?.title = "기타"
            config?.baseBackgroundColor = button.isSelected && button.changesSelectionAsPrimaryAction ? .init(named: "lightred") : .white
          config?.image = button.isSelected && button.changesSelectionAsPrimaryAction ? UIImage(named: "checkedicon")
            : .none
            var arr = AttributedString.init("기타")
            arr.font = .systemFont(ofSize: 13.0, weight: .regular)
            config?.attributedTitle = arr
          button.configuration = config
            if self.button5.isSelected {
                self.selectCategory = "ETC"
            }
            self.button1.isSelected = false
            self.button2.isSelected = false
            self.button3.isSelected = false
            self.button4.isSelected = false
        }
        
        button5.layer.borderWidth = 1
        button5.layer.borderColor = UIColor.lightGray.cgColor
        button5.layer.cornerRadius = 16
    }
    
    func createConfig5() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.cornerStyle = .capsule
        config.baseForegroundColor = .darkGray
        var titleAttr = AttributedString.init("button5")
        titleAttr.font = .systemFont(ofSize: 11.0, weight: .regular)
            config.attributedTitle = titleAttr
        return config
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
    
    
    @IBAction func FindAddressButton(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            guard let svc3 = self.storyboard?.instantiateViewController(identifier: "UserAddressViewController") as? UserAddressViewController else {
                return
            }
            svc3.delegate = self
            self.present(svc3, animated: true)
        }
    }
    
    @IBAction func UploadImageButton(_ sender: Any) {
        self.imagePickerController.delegate = self
               self.imagePickerController.sourceType = .photoLibrary
               present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userProfileImage?.image = image
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                DiaryPost.instance.uploadDiary(file: self.userProfileImage.image!, url: self.serverURL) { result in self.imageUrl = result }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.storeImageUrl = self.imageUrl.result
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil) //dismiss를 직접 해야함
    }
    
    func isSelectedCategory() {
        if selectCategory == "CAFE" {
            button1.isSelected = true
            button1.changesSelectionAsPrimaryAction = true
            button2.isSelected = false
            button2.changesSelectionAsPrimaryAction = true
            button3.isSelected = false
            button3.changesSelectionAsPrimaryAction = true
            button4.isSelected = false
            button4.changesSelectionAsPrimaryAction = true
            button5.isSelected = false
            button5.changesSelectionAsPrimaryAction = true
        } else if selectCategory == "LIFE" {
            button2.isSelected = true
            button2.changesSelectionAsPrimaryAction = true
            button1.isSelected = false
            button1.changesSelectionAsPrimaryAction = true
            button3.isSelected = false
            button3.changesSelectionAsPrimaryAction = true
            button4.isSelected = false
            button4.changesSelectionAsPrimaryAction = true
            button5.isSelected = false
            button5.changesSelectionAsPrimaryAction = true
        } else if selectCategory == "SIDEDISH" {
            button3.isSelected = true
            button3.changesSelectionAsPrimaryAction = true
            button1.isSelected = false
            button1.changesSelectionAsPrimaryAction = true
            button2.isSelected = false
            button2.changesSelectionAsPrimaryAction = true
            button4.isSelected = false
            button4.changesSelectionAsPrimaryAction = true
            button5.isSelected = false
            button5.changesSelectionAsPrimaryAction = true
        } else if selectCategory == "FASHION" {
            button4.isSelected = true
            button4.changesSelectionAsPrimaryAction = true
            button1.isSelected = false
            button1.changesSelectionAsPrimaryAction = true
            button2.isSelected = false
            button2.changesSelectionAsPrimaryAction = true
            button3.isSelected = false
            button3.changesSelectionAsPrimaryAction = true
            button5.isSelected = false
            button5.changesSelectionAsPrimaryAction = true
        } else if selectCategory == "ETC" {
            button5.isSelected = true
            button5.changesSelectionAsPrimaryAction = true
            button1.isSelected = false
            button1.changesSelectionAsPrimaryAction = true
            button2.isSelected = false
            button2.changesSelectionAsPrimaryAction = true
            button3.isSelected = false
            button3.changesSelectionAsPrimaryAction = true
            button4.isSelected = false
            button4.changesSelectionAsPrimaryAction = true
        }
    }
    
    
    // 이미지 post
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

