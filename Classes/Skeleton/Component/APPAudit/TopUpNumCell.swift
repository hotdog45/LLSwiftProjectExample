//
//  TopUpNumCell.swift
//  KDTK
//
//  Created by 李顺风 on 2017/6/13.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class TopUpNumCell: UITableViewCell {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var NumLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    //设置样式
    func setTypeCell(_ index : Int) {
        switch index {
        case 1:
            titleLable.text = "1元"
            NumLable.text = "￥1.00"
        case 2:
            titleLable.text = "6元"
            NumLable.text = "￥6.00"
        case 3:
            titleLable.text = "18元"
            NumLable.text = "￥18.00"
        case 4:
            titleLable.text = "30元"
            NumLable.text = "￥30.00"
        case 5:
            titleLable.text = "50元"
            NumLable.text = "￥50.00"
        case 6:
            titleLable.text = "93元"
            NumLable.text = "￥93.00"
        case 7:
            titleLable.text = "168元"
            NumLable.text = "￥168.00"
        default:
            titleLable.text = "248元"
            NumLable.text = "￥248.00"
        }
    }
}
