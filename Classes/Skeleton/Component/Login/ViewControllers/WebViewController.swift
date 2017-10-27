//
//  WebViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/5/26.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    var urlStr = ""
    @IBOutlet weak var webView: UIWebView!
    @IBAction func popClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlStr.characters.count == 0 {
            LLHUBErr("网络错误！")
        }else{
            let url = try! urlStr.asURL()
            webViewLoad(url)
        }
    }
//
    func webViewLoad(_ detailURL : URL) {
        // 发送网络请求
        
        let request = URLRequest.init(url: detailURL)
        webView.loadRequest(request)
        // 设置UIWebView接收的数据是否可以通过手势来调整页面内容大小
        webView.scalesPageToFit = true
        // 设置UIWebView的代理对象
        webView.delegate = self
    }
    

    

}
// MARK: - UIWebViewDelegate
extension WebViewController: UIWebViewDelegate {
    // 该方法是在UIWebView在开发加载时调用
    @objc(webViewDidStartLoad:) func webViewDidStartLoad(_ webView: UIWebView) {
        //        LLHUB("开始加载")
        SVProgressHUD.showInfo(withStatus: "开始加载")
        
    }
    
    // 该方法是在UIWebView加载完之后才调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // 该方法是在UIWebView请求失败的时候调用
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        LLHUBErr("加载失败")
    }
}
