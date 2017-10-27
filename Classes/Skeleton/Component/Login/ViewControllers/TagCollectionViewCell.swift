//
//  TagCollectionViewCell.swift
//  KDTK
//
//  Created by 李顺风 on 2017/6/29.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30/2
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.LLColorValue(value: "#D9D9D9").cgColor
    }

}
