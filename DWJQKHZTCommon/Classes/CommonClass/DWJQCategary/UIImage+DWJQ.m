//
//  UIImage+DWJQ.m
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "UIImage+DWJQ.h"
#import <Accelerate/Accelerate.h>
#import "DWJQ+Compression.h"

@implementation UIImage (DWJQ)
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (instancetype)resizableImageWithName:(NSString *)imageName
{
    return [self resizableImageWithName:imageName leftRatio:0.5 topRatio:0.5];
}

+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    // 1.创建图片
    UIImage *image = [UIImage imageNamed:imageName];
    // 2.处理图片
    CGFloat left = image.size.width * leftRatio;
    CGFloat top = image.size.height * topRatio;
    
    image =  [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    // 3.返回图片
    return image;
}

- (UIImage*)scaleToSize:(CGSize)size withColor:(UIColor *)color
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (instancetype)imageFromColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithNameToDifferentScreemWithBaseName:(NSString *)baseName
{
    UIImage *image = nil;
    
    if (baseName) {
        NSString *subStr=@"";
        if (DWJQThreeHalfInch) {
            //3.5
            subStr=@"_3_5";
        }else if (DWJQFourInch){
            //4
            subStr=@"_4";
        }else if (DWJQFourSevenInch){
            //4.7
            subStr=@"_4_7";
        }else{
            //5.5
            subStr=@"_5_5";
        }
        NSString *fullName=[NSString stringWithFormat:@"%@%@",baseName,subStr];
        image =  [UIImage imageNamed:fullName];
    }
    return image;
}

+ (UIImage *)screenCaptureFromView:(UIView *)view
{
    UIImage *img = [UIImage screenCaptureFromView:view clipRect:CGRectZero];
    return img;
}

+ (UIImage *)screenCaptureFromView:(UIView *)view clipRect:(CGRect)clipRect
{
    // 1.
    UIScrollView *scrollView = nil;
    CGPoint savedContentOffset = CGPointZero;
    CGRect savedFrame = CGRectZero;
    if ([view isKindOfClass:[UIScrollView class]]) {
        scrollView = (UIScrollView *)view;
        savedContentOffset = scrollView.contentOffset;
        savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    }
    
    // 2.
    if (!CGRectIsEmpty(clipRect)) {
        UIGraphicsBeginImageContextWithOptions(clipRect.size, YES, 0.0);
    } else {
        if (scrollView) {
            UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, 0.0);
        } else {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!CGRectIsEmpty(clipRect)) {
        CGContextTranslateCTM(context, -clipRect.origin.x, -clipRect.origin.y);
    }
    if (IS_GREATER_OR_EQUAL_IOS8_1 && IS_LESS_IOS8_2) {
    }else{
        [view.layer renderInContext:context];
    }
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 3.
    if (scrollView) {
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    if (IS_GREATER_OR_EQUAL_IOS8_1 && IS_LESS_IOS8_2) {
        img = [UIImage imageFromColor:DWJQCOLOR_WHITE size:view.bounds.size];
    }else{
    }
    
    return img;
}

+ (UIImage *)decode:(UIImage *)image
{
    if(image==nil) {  return nil; }
    
    UIGraphicsBeginImageContext(image.size);
    {
        [image drawAtPoint:CGPointMake(0, 0)];
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return image;
}

//截取部分图像
+ (UIImage*)getSubImage:(UIImage *)img rect:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    return smallImage;
}

+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect
{
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    [otherImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//合并图像
+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect transform:(CGAffineTransform)transform
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height),
                                           NO,
                                           image.scale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    UIImage *image1 = [UIImage imageRotatedDWJQDegrees:transform image:otherImage];
    [image1 drawInRect:rect
             blendMode:kCGBlendModeNormal
                 alpha:1.0f];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)imageRotatedDWJQDegrees:(CGAffineTransform)transform image:(UIImage *)image
{
    CGSize imageSize = image.size;
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    rotatedViewBox.transform = transform;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    
    
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height/2);
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextConcatCTM(bitmap, CGAffineTransformInvert(transform));
    
    CGRect f = CGRectMake(-imageSize.width / 2, -imageSize.height / 2, imageSize.width, imageSize.height);
    CGContextDrawImage(bitmap, f, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //    CGSize newImageSize = newImage.size;
    UIGraphicsEndImageContext();
    return newImage;
    
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToWidth:(CGFloat)newWidth
{
    CGFloat newHeight = newWidth * image.size.height/image.size.width;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark 保存图片到document
+(NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    return [self saveData:imageData WithName:imageName];
}

+(NSString *)saveData:(NSData *)data WithName:(NSString *)imageName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    [data writeToFile:fullPathToFile atomically:NO];
    return [NSString stringWithFormat:@"%@",fullPathToFile];
}


+ (void)savePhotosAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
}
+(void)deleteFileFromPath:(NSString *)path{
    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:path error:nil];
}
+(UIImage *)imageFromString:(NSString *)string inRect:(CGRect)rect {
    UIImage *image = [UIImage imageWithContentsOfFile:string];
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

// base64字符串转为UIImage对象

+ (UIImage *)imageFromBase64String:(NSString *)base64String
{
    NSData *decodedImageData   = [[NSData alloc] initWithBase64EncodedString:base64String];
    UIImage *decodedImage      = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}
+ (UIImage *)imageWithNameByMobileType:(NSString *)name
{
    switch ((int)kDWJQScreenWidth) {
        case 320:
            name = [name stringByAppendingString:@"320"];
            break;
        case 375:
            name = [name stringByAppendingString:@"375"];
            break;
        case 414:
            name = [name stringByAppendingString:@"414"];
            break;
        default:
            break;
    }
    UIImage *image = [UIImage imageNamed:name];
    return image;
}
@end


@implementation UIImage (camera)

-(UIImage*)rotate:(UIImageOrientation)orient
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    bnds.size = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
    rect.size = CGSizeMake(CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
    
    switch (orient)
    {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationRight:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        case UIImageOrientationRightMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copy;
}

-(UIImage*)scaleWithMaxSize:(CGSize)maxSize
                    quality:(CGInterpolationQuality)quality
{
    CGRect        bnds = CGRectZero;
    UIImage*      copy = nil;
    CGContextRef  ctxt = nil;
    CGRect        orig = CGRectZero;
    CGFloat       rtio = 0.0;
    CGFloat       scal = 1.0;
    
    bnds.size = self.size;
    orig.size = self.size;
    rtio = (orig.size.width/maxSize.width) / (orig.size.height/maxSize.height);
    
    if ((orig.size.width <= maxSize.width) && (orig.size.height <= maxSize.height))
    {
        return self;
    }
    
    if (rtio > 1.0)
    {
        rtio = maxSize.width/bnds.size.width;
    }
    else
    {
        rtio = maxSize.height/bnds.size.height;
    }
    
    bnds.size.width  = rtio*bnds.size.width;
    bnds.size.height = rtio*bnds.size.height;
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    scal = bnds.size.width / orig.size.width;
    CGContextSetInterpolationQuality(ctxt, quality);
    CGContextScaleCTM(ctxt, scal, -scal);
    CGContextTranslateCTM(ctxt, 0.0, -orig.size.height);
    CGContextDrawImage(ctxt, orig, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copy;
}

- (UIImage*)scaleWithScale:(CGFloat)scale
                   quality:(CGInterpolationQuality)quality
{
    CGSize s = CGSizeMake(self.size.width * scale, self.size.height * scale);
    UIImage *image = nil;
    image = [self scaleWithMaxSize:s quality:quality];
    return image;
}
+ (UIImage *)imageWithNameByMobileType:(NSString *)name
{
    switch ((int)kDWJQScreenWidth) {
        case 320:
            name = [name stringByAppendingString:@"320"];
            break;
        case 375:
            name = [name stringByAppendingString:@"375"];
            break;
        case 414:
            name = [name stringByAppendingString:@"414"];
            break;
        default:
            break;
    }
    UIImage *image = [UIImage imageNamed:name];
    return image;
}
/**
 *  输出一张大小不大于imageByte的图片
 *
 */
- (UIImage*)imageWithFitSize:(NSUInteger)imageByte
{
    UIImage *newImage = nil;
    if (imageByte <= 0) {//图片的默认大小为100kb
        imageByte = 100 * 1024;
    }
    NSData *oimageData = UIImagePNGRepresentation(self);
    if (oimageData.length <= imageByte) {
        newImage  = self;
    }else{
        NSData *pointZeroImageData = UIImageJPEGRepresentation(self , 0.1);
        
        if (pointZeroImageData.length > imageByte) {
            CGFloat scale = pointZeroImageData.length / imageByte;
            NSInteger val = sqrt(scale);
            if (val < 2) {
                val = 2;
            }
            CGSize originalSize = self.size;
            UIImage *tempImage =  [self imageByScalingAndCroppingForSize:CGSizeMake(originalSize.width / val, originalSize.height / val)];
            newImage = tempImage;
        }else{
            newImage = self;
        }
    }
    return newImage;
}
- (UIImage*)imageWithFitSize:(NSUInteger)imageByte originalSize:(long long)imageSize
{
    if (imageSize <= 0) {
        return  [self imageWithFitSize:imageByte];
    }else{
        UIImage *newImage = nil;
        if (imageByte <= 0) {//图片的默认大小为100kb
            imageByte = 100 * 1024;
        }
        if (imageSize <= imageByte) {
            newImage  = self;
        }else{
            NSData *pointZeroImageData = UIImageJPEGRepresentation(self , 0.1);
            if (pointZeroImageData.length > imageByte) {
                CGFloat scale = pointZeroImageData.length / imageByte;
                NSInteger val = sqrt(scale);
                if (val < 2) {
                    val = 2;
                }
                CGSize originalSize = self.size;
                UIImage *tempImage =  [self imageByScalingAndCroppingForSize:CGSizeMake(originalSize.width / val, originalSize.height / val)];
                newImage = tempImage;
            }else{
                newImage = self;
            }
        }
        return newImage;
    }
}
//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {

        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}
@end
