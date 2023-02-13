//
//  WriteReviewViewController.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/01/23.
//

import UIKit

class WriteReviewViewController: UIViewController, UITextViewDelegate {
    
    var writeRebornData:[postReviewReqResultModel]!
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var testImage: UIImageView!
    
    
//    let stringToNum = self().countLabel.text
//    let dd = Int(stringToNum)
    
    lazy var stringToNum = UInt(label.text ?? "")
    
    var Number = 0
    
    var imageDatas = [1, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ======== 상세 리뷰 작성 textField ========
        self.textField.layer.borderWidth = 1.0
        self.textField.layer.borderColor=UIColor.lightGray.cgColor
        self.textField.text = "리본 후기를 알려주세요!"
        self.textField.textColor=UIColor.lightGray
        self.textField.returnKeyType = .done
        self.textField.delegate = self
        self.textField.textContainer.lineFragmentPadding = 8
        self.textField.layer.cornerRadius = 8

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
}
