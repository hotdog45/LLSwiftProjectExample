//
//  KDWebVC.swift
//  KDTK
//
//  Created by 李顺风 on 2017/4/10.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class KDWebVC: BaseViewController {

    var urlStr = ""
    var key = ""
    var value = ""
    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if key.isEmpty || value.isEmpty {
            self.setupRightButtonWithImage(image: UIImage.init(named: "ic_h5_share")!, action: #selector(rightButtonClick))
        }
        let strTemp = urlStr.replacingOccurrences(of: " ", with: "")
        let url = URL(string: strTemp)
        if url == nil {
            LLHUBErr("链接有误")
        }else{
            webViewLoad(url!)
        }
       
        
        self.title = "测试"
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ObjectWithSwift.webViewNewAgent()
        if !key.isEmpty && !value.isEmpty {
            ObjectWithSwift.setCookie(key, value:value )
        }
        
    }
    
    
    override func clickedBackButton() {
        if WebView.canGoBack && key.isEmpty && value.isEmpty{
            self.WebView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func reloadWebData() {
        let url = URL(string: urlStr)
        if url == nil {
            LLHUBErr("链接有误")
        }else{
            webViewLoad(url!)
        }
    }
    
    func webViewLoad(_ detailURL : URL) {
        // 发送网络请求
        let request = URLRequest.init(url: detailURL)
        WebView.loadRequest(request)
        // 设置UIWebView接收的数据是否可以通过手势来调整页面内容大小
        WebView.scalesPageToFit = true
        // 设置UIWebView的代理对象
        WebView.delegate = self
    }
    
    func rightButtonClick() {
        let shareM = ShareModel()
        shareM.title = self.title!
        shareM.des = self.title!
        shareM.url = urlStr
        ShareViewController.showShare(shareM)
    }

}

// MARK: - UIWebViewDelegate
extension KDWebVC: UIWebViewDelegate {
    // 该方法是在UIWebView在开发加载时调用

    
    // 该方法是在UIWebView加载完之后才调用
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        SVProgressHUD.dismiss()
    }
    
    // 该方法是在UIWebView请求失败的时候调用
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        LLHUBErr("加载失败")
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        println("\(urlStr)---------\(String(describing: request.url?.absoluteString))")

        
        if  !(request.url?.absoluteString == urlStr) {

            urlStr = (request.url?.absoluteString.substring(from: "kdtkapp://login/?url=".endIndex))!
//            return UrlRouteCenter().urlRouteToVC((request.url?.absoluteString)!)
        }
        return true
    }
    
    
    
}
