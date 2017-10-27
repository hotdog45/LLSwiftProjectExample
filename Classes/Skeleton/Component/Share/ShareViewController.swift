//
//  ShareViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/20.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit
import MBProgressHUD


enum shareplatform {
    case wechat
    case wechatmoments
    case weibo
    case qq
    case qqzone
    
}

class ShareViewController: UIViewController {
    var msg = OSMessage()
    var _success: shareSuccess?
    var _fail : shareFail?
    var shareUrl :String!
    
    
    @IBOutlet weak var bgview: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    

    
    class func initWithShareModel(ShareModel: String){
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 0.2, animations: {
//            self.bgview.alpha = 0.3
//        })
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.1, animations: {
            self.view.alpha = 0
            self.bgview.alpha = 0.4
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .custom
        self.bgView.backgroundColor = UIColor.clear
//        initView()
    }
    
    private func initView(_ model :ShareModel){
        msg.desc = model.des
        msg.title = model.title
        msg.link =  model.url
        msg.image = UIImage.init(named: "share_60")
        msg.thumbnail = UIImage.init(named: "share_60")
        msg.multimediaType = OSMultimediaType.init(0)
        
    }
    
    class public func showShare(_ model :ShareModel) {
        let share = ShareViewController()
        share.present()
        share.initView(model)
    }
    
    
    func present() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .fullScreen
        self.view.backgroundColor = .clear
        UIApplication.topViewController()?.present(self, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func copyLink(_ sender: Any) {
//        UIPasteboard.general.string = "已复制";
        UIPasteboard.general.string = msg.link
        LLHUBSuc("复制成功")
        self.dismiss(animated: true)
        
        
    }
    
    @IBAction func Wechat(_ sender: Any) {
        
        msg.multimediaType = OSMultimediaTypeNews;
        OpenShare.share(toWeixinSession: msg, success: _success, fail: _fail)
        self.dismiss(animated: true)
        
    }
    
    
    
    @IBAction func WechatMoments(_ sender: Any) {
        
        msg.multimediaType = OSMultimediaTypeNews;
        OpenShare.share(toWeixinTimeline: msg, success: _success, fail: _fail)
        self.dismiss(animated: true)
    }
    @IBAction func QQ(_ sender: Any) {
        msg.multimediaType = OSMultimediaTypeNews;
        OpenShare.share(toQQFriends: msg, success: _success, fail: _fail)
        self.dismiss(animated: true)
    }
    
    
    @IBAction func WeiBo(_ sender: Any) {
        
        msg.multimediaType = OSMultimediaTypeNews;
        OpenShare.share(toWeibo: msg, success: _success, fail: _fail)
        self.dismiss(animated: true)
        
    }
    
    

}
