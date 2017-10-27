//
//  UIButton+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/20.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UIButton {
    
    func changeImageToRight() {
        guard let _ = self.currentImage , let _ = self.titleLabel else {
            return
        }
        
        let titleSize = self.titleLabel!.sizeThatFits(self.frame.size)
        let buttonW = self.frame.size.width
        
        var titleEdge = self.titleEdgeInsets
        titleEdge.left = -self.imageView!.frame.size.width - 5
        self.titleEdgeInsets = titleEdge
        
        var imageEdge = self.imageEdgeInsets
        imageEdge.left = buttonW/2 + titleSize.width/2
        self.imageEdgeInsets = imageEdge

    }
    
    func revolveButtonImage() {
        guard let _ = self.currentImage else {
            return
        }
        self.imageView!.transform = CGAffineTransform(rotationAngle: .pi/2);
    }
}
