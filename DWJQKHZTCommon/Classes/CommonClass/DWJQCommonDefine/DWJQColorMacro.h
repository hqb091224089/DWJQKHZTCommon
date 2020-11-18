//
//  DWJQColorMacro.h
//  DWJQ
//
//  Created DWJQ luoxingyu on 16/4/15.
//  Copyright © 2016年 logictech. All rights reserved.
//

#ifndef DWJQColorMacro_h
#define DWJQColorMacro_h

// 1.
#define DWJQColorWithRGB(r, g, b) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1])
#define DWJQColorWithRGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)])


typedef NSUInteger DWJQRgbValue;
#define RGBVALUE(r, g, b) ( (((DWJQRgbValue)(r) & 0xFF) << 16) \
+ (((DWJQRgbValue)(g) & 0xFF) << 8) \
+ ((DWJQRgbValue)(b) & 0xFF) )

#define RGBAVALUE(r, g, b, a) ((((DWJQRgbValue)(r) & 0xFF) << 24) \
+ (((DWJQRgbValue)(g) & 0xFF) << 16) \
+ (((DWJQRgbValue)(b) & 0xFF) << 8) \
+ ((DWJQRgbValue)(a) & 0xFF))

#define RVALUE_FROM_RGB(rgb) (((rgb) & 0xFF0000) >> 16)
#define GVALUE_FROM_RGB(rgb) (((rgb) & 0xFF00) >> 8)
#define BVALUE_FROM_RGB(rgb) ((rgb) & 0xFF)

#define RVALUE_FROM_RGBA(rgba) (((rgba) & 0xFF000000) >> 24)
#define GVALUE_FROM_RGBA(rgba) (((rgba) & 0xFF0000) >> 16)
#define BVALUE_FROM_RGBA(rgba) (((rgba) & 0xFF00) >> 8)
#define AVALUE_FROM_RGBA(rgba) ((rgba) & 0xFF)


// 2.
#define DWJQColorWithRGBValue(rgb) ([UIColor \
colorWithRed:((float)RVALUE_FROM_RGB(rgb))/255.0 \
green:((float)GVALUE_FROM_RGB(rgb))/255.0 \
blue:((float)BVALUE_FROM_RGB(rgb))/255.0 \
alpha:1.0])

#define DWJQColorWithRGBAValue(rgba) ([UIColor \
colorWithRed:((float)RVALUE_FROM_RGBA(rgba))/255.0 \
green:((float)GVALUE_FROM_RGBA(rgba))/255.0 \
blue:((float)BVALUE_FROM_RGBA(rgba))/255.0 \
alpha:((float)AVALUE_FROM_RGBA(rgba))/255.0])


#define DWJQColroWithRGBValue_A(rgb, a) ([UIColor \
colorWithRed:((float)RVALUE_FROM_RGB(rgb))/255.0 \
green:((float)GVALUE_FROM_RGB(rgb))/255.0 \
blue:((float)BVALUE_FROM_RGB(rgb))/255.0 \
alpha:(a)])


// 随机色
#define DWJQCOLOR_RANDOM        DWJQColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#endif /* DWJQColorMacro_h */
