//
//  WhoViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/26.
//

import UIKit



class WhoViewController: UIViewController {

    @IBOutlet weak var ProgressView2: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let mybrown1 = UIColor(named: "mybrown")
        //let myorange1 = UIColor(named: "myorange")
        
        // navigation : back button custom
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        
        
        //progressView2
        ProgressView2.progressViewStyle = .default
        ProgressView2.progressTintColor = .myorange
        ProgressView2.progress = 2/6
        
        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
    }
    

}


