//
//  DWJQFileHelper.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/18.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWJQFileHelper : NSObject

+ (long long)fileSizeAtPath:(NSString*)filePath;

// 获取目录下文件大小
+ (CGFloat)folderSizeAtPath:(NSString*)folderPath;

// 删除文件夹
+ (BOOL)removeFolderAtPath:(NSString*)folderPath;

@end
