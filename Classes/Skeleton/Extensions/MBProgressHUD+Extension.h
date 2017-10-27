//
//  MBProgressHUD+Extension.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Extension)
/**
 *  成功后的显示的HUD
 *
 *  @param success 需要显示的提示信息
 *  @param view    显示的view
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
/**
 *  失败后的显示的HUD
 *
 *  @param error 需要显示的提示信息
 *  @param view    显示的view
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;
/**
 *  创建显示信息的HUD
 *
 *  @param message 信息
 *  @param view    需要显示的view
 *
 *  @return hud
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  成功的显示信息 显示到window上
 *
 *  @param success 提示信息
 */
+ (void)showSuccess:(NSString *)success;
/**
 *  失败的显示信息 显示到window上
 *
 *  @param error 提示信息
 */
+ (void)showError:(NSString *)error;
/**
 *  显示信息
 *
 *  @param message 信息
 *
 *  @return hud
 */
+ (MBProgressHUD *)showMessage:(NSString *)message;

/**
 *  显示加载,无文字
 *
 *
 *  @return hud
 */
+ (MBProgressHUD *)showPHUD;
/**
 *  隐藏信息
 *
 *  @param view view
 */
+ (void)hideHUDForView:(UIView *)view;
/**
 *  隐藏
 */
+ (void)hideHUD;




//+ (void)showHudWithView:(UIView *)view;
//
//+ (void)showGifHudWithImageName:(NSString *)imageName andView:(UIView *)view;
@end
