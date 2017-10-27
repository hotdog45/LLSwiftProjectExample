//
//  MBProgressHUD+Extension.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/23.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "MBProgressHUD+Extension.h"
#import "UIImage+GIF.h"
@implementation MBProgressHUD (Extension)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 0.7秒之后再消失
    [hud hideAnimated:YES afterDelay:1.25];

}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"MyIcon.bundle/error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"MyIcon.bundle/success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showPHUD{
    return [self showMessage:@"" toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideAllHUDsForView:[[UIApplication sharedApplication].windows lastObject] animated:YES];
}


+ (void)showHudWithView:(UIView *)view{
   MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    [HUD setColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    UIImage *image = [UIImage sd_animatedGIFNamed:@"jhLoading"];
    
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    //    HUD.labelText = @"加载中。。。";
    
    HUD.mode = MBProgressHUDModeCustomView;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    //    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [view bringSubviewToFront:HUD];
    
    [HUD show:YES];
}
+ (void)showGifHudWithImageName:(NSString *)imageName andView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
//    [HUD setColor:[UIColor colorWithHexString:@"#333333"]];
    
    UIImage *image = [UIImage sd_animatedGIFNamed:imageName];
    
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    //    HUD.labelText = @"加载中。。。";
    
    HUD.mode = MBProgressHUDModeCustomView;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    //    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [view bringSubviewToFront:HUD];
    
    [HUD show:YES];
}



+ (UIImage *)sd_animatedGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage sd_animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
    }
}

@end
