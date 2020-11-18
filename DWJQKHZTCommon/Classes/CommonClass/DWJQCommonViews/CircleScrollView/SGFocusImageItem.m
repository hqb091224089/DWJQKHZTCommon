//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem
@synthesize title = _title;
@synthesize image = _image;
@synthesize detailUrl = _detailUrl;
@synthesize tag = _tag;

- (void)dealloc
{
    self.title = nil;
    self.image = nil;
    self.detailUrl = nil;
    self.imageUrl = nil;
    self.imageData = nil;
    [super dealloc];
}
- (id)initWithTitle:(NSString *)title image:(NSString *)image detailUrl:(NSString *)detailUrl tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.title = title;
        self.image = image;
        self.detailUrl = detailUrl;
        self.tag = tag;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            self.title = [dict objectForKey:@"title"];
            self.image = [dict objectForKey:@"image"];
            self.detailUrl = [dict objectForKey:@"detailUrl"];
            self.imageData = [dict objectForKey:@"imageData"];
            self.imageUrl = [dict objectForKey:@"imageUrl"];
            self.tag = tag;
            //...
        }
    }
    return self;
}



@end
