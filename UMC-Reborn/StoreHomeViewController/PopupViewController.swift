//
//  PopupViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/14.
//

import UIKit

protocol SampleProtocol:AnyObject {
    func dataSend(data: String)
}

class PopupViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!    
    @IBOutlet weak var popupPicker: UIPickerView!
    @IBOutlet weak var timeLabel2: UILabel!
    
    weak var delegate : SampleProtocol?
    
    var hour = ""
    var minute = ""
    
    var pickerHour = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    var pickerMinute = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.clipsToBounds = true
        cancelButton.layer.cornerRadius = 0
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor(red: 64/255, green: 49/255, blue: 35/255, alpha: 1).cgColor
        yesButton.layer.cornerRadius = 0
        yesButton.layer.borderWidth = 1
        
        popupPicker.delegate = self
        popupPicker.dataSource = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if let text = timeLabel2.text {
            delegate?.dataSend(data: text)
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension PopupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
                case 0:
                    return pickerHour.count /// 연도의 아이템 개수
                case 1:
                    return pickerMinute.count /// 월의 아이템 개수
                default:
                    return 0
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
            case 0:
                return "\(pickerHour[row])"
            case 1:
                return "\(pickerMinute[row])"
            default:
                return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel?
        if label == nil {
            label = UILabel()
            label?.textColor = UIColor.black
            label?.textAlignment = .center
        }
        switch component {
            case 0:
                label?.text = pickerHour[row] + "시간"
                label?.font = UIFont(name:"AppleSDGothicNeo-Bold", size:20)
                return label!
            case 1:
                label?.text = pickerMinute[row] + "분"
                label?.font = UIFont(name:"AppleSDGothicNeo-Bold", size:20)
                return label!
            default:
                return label!
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            hour = pickerHour[row]
        case 1:
            minute = pickerMinute[row]
        default:
            timeLabel2.text = "00 시간 00 분"
        }
        
        timeLabel2.text = hour + " 시간 " + minute + " 분"
    }
}
