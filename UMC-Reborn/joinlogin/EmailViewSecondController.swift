//
//  EmailViewSecondController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/02/03.
//

import UIKit

class EmailViewSecondController: UIViewController {

    @IBOutlet weak var Pgemail: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Pgemail.progressViewStyle = .default
        Pgemail.progressTintColor = .myorange
        Pgemail.progress = 0.5
    }
    

    
}
