//
//  Reader.swift
//  KDTK
//
//  Created by 李顺风 on 2017/4/7.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import Foundation
import MBProgressHUD
final class Reader {
    var url = ""
    var i : Float = 0.0
    var timer:Timer!
    
    func downloadReader(url:String)  {
        
        // 创建定时器
        timer = Timer(timeInterval: 0.5,
                      target: self,
                      selector: #selector(getCurrnetPlayerPlayRotate),
                      userInfo: nil,
                      repeats: true)
        // 将定时器添加到运行循环
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
//        SVProgressHUD.showProgress(i)
        self.url = url
        MJDownloadManager.default().download(url, progress: { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            println("bytesWritten---\(bytesWritten)totalBytesWritten---\(totalBytesWritten)errtotalBytesExpectedToWriteor---\(totalBytesExpectedToWrite)")
            DispatchQueue.main.async {
                self.url(self.url)
            }
            
        }, state: { (state, file, error) in
            println("state---\(state)file---\(String(describing: file))error---\(String(describing: error))")
            DispatchQueue.main.async {
                self.url(self.url)
            }
        })
    }
    
    /* 获得当前播放比例 */
    @objc func getCurrnetPlayerPlayRotate(){
       self.url(self.url)
    }

    func url(_ url: String) {
       
        self.url = url
        let info = MJDownloadManager.default().download(url)
        
        let keyWindow = UIApplication.shared.keyWindow
        
        let hud = MBProgressHUD.showAdded(to: keyWindow!, animated: true)
        hud.mode = .annularDeterminate
        hud.removeFromSuperViewOnHide = true
        if info?.state == .completed {
            
            
            // 关闭定时器，永久关闭定时器
            timer.invalidate()
//            SVProgressHUD.dismiss()
            MBProgressHUD.hide()
            let document = ReaderDocument.withDocumentFilePath(info!.file, password: "")
            if document != nil {
                MBProgressHUD.hide()
                let R = ReaderViewController.init(readerDocument: document)
                presentVC(R!)
            }
        }else {
            if info?.state == .none {
            } else {
                if ((info?.totalBytesExpectedToWrite) != nil) {
                    i = Float((info?.totalBytesWritten)!) / Float((info?.totalBytesExpectedToWrite)!)
//                    SVProgressHUD.showProgress(i)
                    hud.progress = i
                }
            }
        }
    }

    
}
