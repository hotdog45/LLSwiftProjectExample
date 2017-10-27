//
//  GetURLFileLength.m
//  KDTK
//
//  Created by 李顺风 on 2017/7/20.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

#import "GetURLFileLength.h"

@implementation GetURLFileLength
/**
 *  通过url获得网络的文件的大小 返回byte
 *
 *  @param url 网络url
 *
 *  @return 文件的大小 byte
 */
- (void)getUrlFileLength:(NSString *)url withResultBlock:(FileLength)block
{
    _block = block;
    NSMutableURLRequest *mURLRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [mURLRequest setHTTPMethod:@"HEAD"];
    mURLRequest.timeoutInterval = 5.0;
    NSURLConnection *URLConnection = [NSURLConnection connectionWithRequest:mURLRequest delegate:self];
    [URLConnection start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSDictionary *dict = [(NSHTTPURLResponse *)response allHeaderFields];
    NSNumber *length = [dict objectForKey:@"Content-Length"];
    [connection cancel];
    if (_block) {
        _block([length longLongValue], nil);    // length单位是byte，除以1000后是KB（文件的大小计算好像都是1000，而不是1024），
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"获取文件大小失败：%@",error);
    if (_block) {
        _block(0, error);
    }
    [connection cancel];
}


- (void)getLocalPathFileLength:(NSString *)fileName created:(UInt32)created
               withResultBlock:(void(^)(long long length, NSString *status))block
{
    // 判断是否已经离线下载了
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // filepath是通过一定的方式拼接的，我的文件一般存在于documents下的LOCAL_SAVE_PATH当中，然后以created作为文件的目录保存，所以完整的路径拼接即如下：
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%d/%@", @"", created, fileName]];
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    if ([filemanager fileExistsAtPath:path]) {
        long long length = [[filemanager attributesOfItemAtPath:path error:nil] fileSize];
        if (block) {
            block(length, @"已下载");
        }
    }
    else {
        if (block) {
            block(0, @"未下载");
        }
    }
}


//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
+ (long long) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
    
    
    
    
    
    
    
    
    
    
@end
