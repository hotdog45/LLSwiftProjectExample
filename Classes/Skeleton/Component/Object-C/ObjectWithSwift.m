//
//  ObjectWithSwift.m
//  KDTK
//
//  Created by 李顺风 on 2017/5/10.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

#import "ObjectWithSwift.h"

@implementation ObjectWithSwift


+ (UILabel *)showLable {
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 300)];
    
    testLabel.backgroundColor = [UIColor lightGrayColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    NSString *strTest2 = @"<img src=\"http://ojlork64e.bkt.clouddn.com/6923bbe711da434d8a024bc65f620386\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/6a97af26fe814568939295d1976c12b3\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/5e81fdc0beac47979fa4902fcc9d9ad6\" alt=\"\" />";
    
    NSData *dataContent = [strTest2  dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableAttributedString *richTxtContent = [[NSMutableAttributedString alloc] initWithData:dataContent options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    
    [richTxtContent addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:10.0] range:NSMakeRange(0, 300)];
    testLabel.attributedText = richTxtContent;
    return testLabel;
}



/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

//json格式字符串转字典：

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}

+ (void)setCookie:(NSString *)key value :(NSString *)v {
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:key forKey:NSHTTPCookieName];
    [cookieProperties setObject:v forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"www.kaoyanjiayou.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
    
}
+ (void) webViewNewAgent {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"old agent :%@", oldAgent);
    //add my info to the new agent
    NSString *newAgent = [oldAgent stringByAppendingString:@"kdtk"];
    NSLog(@"new agent :%@", newAgent);
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    NSLog(@"newnewnewnewnew agent :%@", [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"]);
}

//解码

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    return
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}


+ (CGFloat) getViewHeightWithStr:(NSString *)str textFont:(UIFont *)textFont widthView:(CGFloat)widthView {
    CGSize size = [str boundingRectWithSize:CGSizeMake(widthView, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size;
    return size.height;
}


@end
