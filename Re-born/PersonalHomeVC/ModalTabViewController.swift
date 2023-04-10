//
//  ModalTabViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/15.
//

import UIKit
import Tabman
import Pageboy

class ModalTabViewController: TabmanViewController {
    
    private var viewControllers: Array<UIViewController> = []
    
    @IBOutlet var tabView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
    
    private func setupTab(){
        let firstVC = UIStoryboard.init(name: "Personal_Home", bundle: nil).instantiateViewController(withIdentifier: "ModalFirstVC") as! ModalFirstViewController
        let secondVC = UIStoryboard.init(name: "Personal_Home", bundle: nil).instantiateViewController(withIdentifier: "ModalSecondVC") as! ModalSecondViewController
        
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        
        tabView.backgroundColor = UIColor(red: 255/255, green: 251/255, blue: 249/255, alpha: 1)
        //        tabView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        tabView.layer.borderWidth = 0
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        // 배경 회색으로 나옴 -> 하얀색으로 바뀜
        bar.backgroundView.style = .clear
        // 간격 설정
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 25, bottom: 10, right: 25)
        // 버튼 글씨 커스텀
        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        // 밑줄 쳐지는 부분
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .clear
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }

}

extension ModalTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "리본 항목")
        case 1:
            return TMBarItem(title: "리뷰")
        default:
            let title = "Page \(index)"
           return TMBarItem(title: title)
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
