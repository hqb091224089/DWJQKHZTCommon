//
//  UIImage+DWJQ.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline CGFloat degreesToRadians(CGFloat degrees)
{
    return M_PI * (degrees / 180.0);
}

static inline CGSize swapWidthAndHeight(CGSize size)
{
    CGFloat  swap = size.width;
    size.width  = size.height;
    size.height = swap;
    return size;
}

static inline UIImage* MTDContextCreateRoundedMask( CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br ) {
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast );
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX( rect ), midx = CGRectGetMidX( rect ), maxx = CGRectGetMaxX( rect );
    CGFloat miny = CGRectGetMinY( rect ), midy = CGRectGetMidY( rect ), maxy = CGRectGetMaxY( rect );
    
    CGContextBeginPath( context );
    CGContextSetGrayFillColor( context, 1.0, 0.0 );
    CGContextAddRect( context, rect );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint( context, minx, miny, midx, miny, radius_bl );
    CGContextAddArcToPoint( context, maxx, miny, maxx, midy, radius_br );
    CGContextAddArcToPoint( context, maxx, maxy, midx, maxy, radius_tr );
    CGContextAddArcToPoint( context, minx, maxy, minx, midy, radius_tl );
    CGContextClosePath( context );
    CGContextDrawPath( context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage( context );
    CGContextRelease( context );
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:bitmapContext];
    // image is retained DWJQ the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
}

@interface UIImage (DWJQ)
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
- (UIImage *)scaleToSize:(CGSize)size withColor:(UIColor *)color;
- (UIImage *)scaleToSize:(CGSize)size;
/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName;

/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName  图片名称
 *  @param leftRatio  左边不拉伸比例
 *  @param rigthRatio 顶部不拉伸比例
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;

/**
 *  根据颜色返回一张特定大小的图片
 *
 *  @param color 图片的颜色
 *  @param size  图片的大小
 *
 *  @return 返回的图片
 */
+ (instancetype)imageFromColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithNameToDifferentScreemWithBaseName:(NSString *)baseName;
+ (UIImage *)screenCaptureFromView:(UIView *)view;
+ (UIImage *)screenCaptureFromView:(UIView *)view clipRect:(CGRect)clipRect;


+ (UIImage *)getSubImage:(UIImage *)img rect:(CGRect)rect;
+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect;
+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect transform:(CGAffineTransform)transform;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToWidth:(CGFloat)newWidth;
+ (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+ (NSString *)saveData:(NSData *)data WithName:(NSString *)imageName;
+ (void)savePhotosAlbum:(UIImage *)image;
+ (void)deleteFileFromPath:(NSString *)path;
+ (UIImage *)imageFromString:(NSString *)string inRect:(CGRect)rect;
/**
 *  base64字符串转为UIImage对象
 *
 *  @param base64String base64字符串
 *
 *  @return 返回的图片
 */

+ (UIImage *)imageFromBase64String:(NSString *)base64String;
+ (UIImage *)imageWithNameByMobileType:(NSString *)name;


@end

@interface UIImage (camera)
- (UIImage*)rotate:(UIImageOrientation)orient;
- (UIImage*)scaleWithMaxSize:(CGSize)maxSize
                     quality:(CGInterpolationQuality)quality;

- (UIImage*)scaleWithScale:(CGFloat)scale
                   quality:(CGInterpolationQuality)quality;

/**
 *  输出一张大小不大于imageByte的图片
 *
 */
- (UIImage*)imageWithFitSize:(NSUInteger)imageByte;

/**
 *  根据已经知道大小的图片输出一张大小不大于imageByte的图片（针对大图片）
 *
 */
- (UIImage*)imageWithFitSize:(NSUInteger)imageByte originalSize:(long long)imageSize;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end
