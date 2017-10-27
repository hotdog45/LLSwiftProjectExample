//
//  UILabel+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/9.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UILabel {
    func setLineSpacing(lineSpacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: text!)
        
        attributedString.addAttributes([
            NSKernAttributeName: lineSpacing
            ], range: NSRange(location: 0, length: text!.characters.count))
        attributedText = attributedString
    }
    
    func getLineNumber(withContent content: String, width: CGFloat) -> Double {
        let label = UILabel(frame: self.frame)
        label.font = self.font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = content
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let lineNumber = Double(size.height)/Double(label.font.lineHeight)
    
        return ceil(lineNumber)
    }
    
    func getAttributedTextHeight(width: CGFloat) -> CGFloat {
        let rect = self.attributedText?.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesLineFragmentOrigin], context: nil)
        
        return rect?.height ?? 0
    }
    
    
    func getLableHeight( _ content: String) -> CGFloat {
        let label = UILabel(frame: self.frame)
        label.font = getTextFont()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = content
        let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        
        return size.height
    }
    
    
    
    
}
