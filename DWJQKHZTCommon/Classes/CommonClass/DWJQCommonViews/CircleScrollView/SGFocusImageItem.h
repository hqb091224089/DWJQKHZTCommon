//
//  SGFocusImageItem.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, strong)  NSString     *title;
@property (nonatomic, strong)  NSString      *image;
@property (nonatomic, strong)  NSString     *detailUrl;
@property (nonatomic, assign)  NSInteger     tag;
@property (nonatomic, strong)  NSString      *imageUrl;
@property (nonatomic, strong)  UIImage      *imageData;

- (id)initWithTitle:(NSString *)title image:(NSString *)image detailUrl:(NSString *)detailUrl tag:(NSInteger)tag;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;


@end
