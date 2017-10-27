//
//  ShiftStyeTableViewCell2.m
//  DOPDropDownMenuDemo
//
//  Created by 李顺风 on 15/12/5.
//  Copyright © 2015年 fengweizhou. All rights reserved.
//

#import "ShiftStyeTableViewCell2.h"

@interface ShiftStyeTableViewCell2 ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation ShiftStyeTableViewCell2

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.contentLabel.textColor = [UIColor colorWithRed:60/255.0 green:68/255.0 blue:82/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
    
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentLabel.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    }
    else {
        self.contentLabel.textColor = [UIColor colorWithRed:60/255.0 green:68/255.0 blue:82/255.0 alpha:1];
    }
    
}

#pragma mark - setter && getter

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}


@end
