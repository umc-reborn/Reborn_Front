//
//  StoreMainViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/01/13.
//

import UIKit

class StoreMainViewController: UIViewController {
    
    let storeMain = UserDefaults.standard.integer(forKey: "userIdx")
    var storeText1: Int = 0
    
    @IBOutlet weak var storemainView: UIView!
    @IBOutlet weak var storemainLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("넘겨받은 값은 \(String(storeMain))")
        
        storemainView.clipsToBounds = true
        storemainView.layer.cornerRadius = 20
        storemainView.layer.masksToBounds = false
        storemainView.layer.shadowOffset = CGSize(width: 5, height: 10)
        storemainView.layer.shadowRadius = 10
        storemainView.layer.shadowOpacity = 0.1

        
        let attributedString = NSMutableAttributedString(string: storemainLabel.text!, attributes: [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: -0.01
        ])
        
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 15, weight: .bold), range: (storemainLabel.text! as NSString).range(of: "다시 태어나게"))
        
        self.storemainLabel.attributedText = attributedString
    }
    
    
    @IBAction func enrollButton(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RebornEnrollViewController") as? RebornEnrollViewController else {return}
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}
