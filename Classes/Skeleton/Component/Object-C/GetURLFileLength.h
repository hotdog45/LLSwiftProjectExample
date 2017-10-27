//
//  GetURLFileLength.h
//  KDTK
//
//  Created by 李顺风 on 2017/7/20.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//
/**
 *  @brief 通过网络url获得文件的大小
 */
#import <Foundation/Foundation.h>

@interface GetURLFileLength : NSObject<NSURLConnectionDataDelegate>

typedef void(^FileLength)(long long length, NSError *error);

@property (nonatomic, weak) FileLength block;

/**
 *  通过url获得网络的文件的大小 返回byte
 *
 *  @param url 网络url
 *
 *  @return 文件的大小 byte
 */
- (void)getUrlFileLength:(NSString *)url withResultBlock:(FileLength)block;

/**
 *  通过文件的名字以及创建的时间获得文件的大小 返回byte
 *
 *  @param fileName 文件名字
 *  @param created  文件在服务器的创建时间   通过创建的时间建立的目录文件
 *  @param block length:文件长度， status:是否已经下载 返回 已下载，未下载
 *  @return
 */
- (void)getLocalPathFileLength:(NSString *)fileName created:(UInt32)created
               withResultBlock:(void(^)(long long length, NSString *status))block;


//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath;
//遍历文件夹获得文件夹大小，返回多少M
+ (long long) folderSizeAtPath:(NSString*) folderPath;
@end
