//
//  UtilityFunctions.swift
//  UMC-Reborn
//
//  Created by yeonsu on 2023/02/02.
//

import UIKit

class UtilityFunctions: NSObject {
    
    func simpleAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
}
