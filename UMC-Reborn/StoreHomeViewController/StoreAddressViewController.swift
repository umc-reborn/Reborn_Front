//
//  StoreAddressViewController.swift
//  UMC-Reborn
//
//  Created by jaegu park on 2023/02/12.
//
import WebKit
import UIKit

class StoreAddressViewController: UIViewController {
    
    @IBOutlet var addressWeb: WKWebView!
    
    let indicator = UIActivityIndicatorView(style: .medium)
    let contentController = WKUserContentController()
    let configuration = WKWebViewConfiguration()
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension StoreAddressViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        contentController.add(self, name: "callBackHandler")
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        addressWeb = WKWebView(frame: .zero, configuration: configuration)
    }
}
