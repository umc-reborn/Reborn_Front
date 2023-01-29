//
//  EmailViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/28.
//

import UIKit

//extension FrontCardCreationCollectionViewCell: UITextFieldDelegate {
//    // ✅ textField 에서 편집을 시작한 후
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // 키보드 업
//        textField.becomeFirstResponder()
//        // 입력 시 textField 를 강조하기 위한 테두리 설정
//        textField.borderWidth = 1
//        textField.borderColor = Colors.white.color
//    }
//
//}




class EmailViewController: UIViewController {

    
    @IBOutlet weak var ProgressView3: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        //progressView3
        ProgressView3.progressViewStyle = .default
        ProgressView3.progressTintColor = .myorange
        ProgressView3.progress = 3/6
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
    }
    

}
