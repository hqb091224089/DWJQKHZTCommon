//
//  UIView+DWJQ.h
//  DWJQ
//
//  Created by luoxingyu on 16/4/11.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Frame
 */
@interface UIView (DWJQ)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;


/**
 * Gesture
 */

- (UIGestureRecognizer *)addTapAction:(id)target selector:(SEL)selector;

- (void)drawDashedFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2 WithLineWidth:(int)lineWidth lineHight:(int)lineHight lineSpace:(int)lineSpace lineColor:(UIColor *)lineColor;
/**
 * 依据edge画边框
 * radius 自左上起，顺时针方向上右下左
 */
- (void)drawBorderWithBorderEdge:(UIRectEdge)edge BorderWidth:(CGFloat)width BorderColor:(UIColor *)color CornerRadius:(UIEdgeInsets)radius;
- (void)drawBorderWithBorderEdge:(UIRectEdge)edge BorderWidth:(CGFloat)width BorderColor:(UIColor *)color CornerRadius:(UIEdgeInsets)radius Size:(CGSize)size;
/**
 *  通过归解档的方式来复制UIView
 */
+ (UIView *)copyView:(UIView *)view;
@end
