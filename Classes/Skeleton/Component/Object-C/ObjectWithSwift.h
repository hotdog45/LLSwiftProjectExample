//
//  ObjectWithSwift.h
//  KDTK
//
//  Created by 李顺风 on 2017/5/10.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectWithSwift : NSObject
+ (UILabel *)showLable ;
/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
//请求头
+ (void) webViewNewAgent ;
//setCookie
+ (void)setCookie:(NSString *)key value :(NSString *)v ;
//解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
//计算高度
+ (CGFloat) getViewHeightWithStr:(NSString *)str textFont:(UIFont *)textFont widthView:(CGFloat)widthView ;
@end
