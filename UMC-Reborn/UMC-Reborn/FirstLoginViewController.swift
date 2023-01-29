//
//  FirstLoginViewController.swift
//  UMC-Reborn
//
//  Created by 김예린 on 2023/01/22.
//

import UIKit

final class LoginGroup: UISegmentedControl {

      override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
      }
      override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()
      }
      required init?(coder: NSCoder) {
        fatalError()
      }
    
      // 안먹혀 여기 밑부터
      private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
      }
    
      private lazy var underlineView: UIView = {
        let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let height = 2.0
        let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
        let yPosition = self.bounds.size.height - 1.0
        let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = .green
        self.addSubview(view)
        return view
     }()
     
     override func layoutSubviews() {
       super.layoutSubviews()
       
       let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
       UIView.animate(
         withDuration: 0.1,
         animations: {
           self.underlineView.frame.origin.x = underlineFinalXPosition
         }
       )
     }
}





class FirstLoginViewController: UIViewController {

    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var SecondView: UIView!
    
    @IBOutlet weak var LoginGroup: UISegmentedControl!
    
    @IBAction func switchViews(_ sender:UISegmentedControl){
            
        if sender.selectedSegmentIndex == 0 {
            FirstView.alpha = 1
            SecondView.alpha = 0
        }else{
            FirstView.alpha = 0
            SecondView.alpha = 1
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // viewcontroller 배경 색상 변경 #FFFBF9
        let BACKGROUND = UIColor(named: "BACKGROUND")
        self.view.backgroundColor = BACKGROUND
        
 
      
    }
    

    
    }
        
    
    

    
   

