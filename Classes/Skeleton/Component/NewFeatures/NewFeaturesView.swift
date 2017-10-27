//
//  NewFeaturesView.swift
//  KDTK
//
//  Created by 李顺风 on 2017/5/24.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

class NewFeaturesView: UIView {

    fileprivate lazy var scrollView : UIScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight()))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewFeaturesView {
    fileprivate func setupUI() {
        
        scrollView.contentSize = CGSize(width: screenWidth()*4, height: screenHeight())
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        self.addSubview(scrollView)
        let jumpBtn = UIButton(frame: CGRect(x: screenWidth() - 70, y: 30, width: 50, height: 25))
        jumpBtn.setImage(UIImage.init(named: "ic_jump"), for: .normal)
        jumpBtn.addTarget(self, action: #selector(popNewFeaturesView), for: .touchUpInside)
        self.addSubview(jumpBtn)
        
        for i in 0...3 {
            let imageV = UIImageView(frame: CGRect(x: CGFloat(i)*screenWidth(), y: 0, width: screenWidth(), height: screenHeight()))
            imageV.image = UIImage.init(named: "NewFeatures\(i+1)")
            scrollView.addSubview(imageV)
            if i == 3 {
                let btn = UIButton(frame: CGRect(x: 50, y: screenHeight() - 105, width: screenWidth() - 100, height: 65))
                btn.backgroundColor = UIColor.clear
                btn.addTarget(self, action: #selector(popNewFeaturesView), for: .touchUpInside)
                imageV.addSubview(btn)
                imageV.isUserInteractionEnabled = true
            }
        }
    }
    
    func popNewFeaturesView(){
        self.removeFromSuperview()
        UserDefaults.standard.set(true, forKey: "isNoNewFeatures525")
    }
    
}

extension NewFeaturesView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > screenWidth() * 3 + 90 {
            popNewFeaturesView()
        }
    }

}
