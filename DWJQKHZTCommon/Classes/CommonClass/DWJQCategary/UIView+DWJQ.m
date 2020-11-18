//
//  UIView+DWJQ.m
//  DWJQ
//
//  Created by luoxingyu on 16/4/11.
//  Copyright © 2016年 logictech. All rights reserved.
//

#import "UIView+DWJQ.h"

#pragma mark - UIView (Frame)

@implementation UIView (DWJQ)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - UIView (Gesture)

- (UIGestureRecognizer *)addTapAction:(id)target selector:(SEL)selector
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer: tapGestureRecognizer];
    return tapGestureRecognizer;
}

/**
 *  画虚线
 */
- (void)drawDashedFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2 WithLineWidth:(int)lineWidth lineHight:(int)lineHight lineSpace:(int)lineSpace lineColor:(UIColor *)lineColor{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:lineHight];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth], [NSNumber numberWithInt:lineSpace], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point1.x, point1.y);
    CGPathAddLineToPoint(path, NULL,point2.x, point2.y);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

+ (UIRectCorner)cornerWithEdge:(UIRectEdge)edge{
    BOOL top    = (edge&UIRectEdgeTop)      ==UIRectEdgeTop;
    BOOL left   = (edge&UIRectEdgeLeft)     ==UIRectEdgeLeft;
    BOOL bottom = (edge&UIRectEdgeBottom)   ==UIRectEdgeBottom;
    BOOL right  = (edge&UIRectEdgeRight)    ==UIRectEdgeRight;
    UIRectCorner corner = 0;
    if (top&&right) {
        corner = corner|UIRectCornerTopRight;
    }
    if (top&&left) {
        corner = corner|UIRectCornerTopLeft;

    }
    if (bottom&&right) {
        corner = corner|UIRectCornerBottomRight;
    }
    if (bottom&&left) {
        corner = corner|UIRectCornerBottomLeft;
    }
    return corner;
}
- (void)drawBorderWithBorderEdge:(UIRectEdge)edge BorderWidth:(CGFloat)width BorderColor:(UIColor *)color CornerRadius:(UIEdgeInsets)radius{
    [self drawBorderWithBorderEdge:edge BorderWidth:width BorderColor:color CornerRadius:radius Size:CGSizeZero];
}
- (void)drawBorderWithBorderEdge:(UIRectEdge)edge BorderWidth:(CGFloat)width BorderColor:(UIColor *)color CornerRadius:(UIEdgeInsets)radius Size:(CGSize)size{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = self.frame.size;
    }
    UIBezierPath *path = [UIBezierPath  bezierPath];
    path.lineWidth = width;
    UIRectCorner corner = [UIView cornerWithEdge:edge];
    CGPoint firstTop = CGPointZero;
    if ((corner&UIRectCornerTopLeft) == UIRectCornerTopLeft) {
        firstTop = CGPointMake(radius.top, 0);
    }
    [path moveToPoint:firstTop];
    CGPoint secondTop = CGPointMake(size.width, 0);
    if ((edge&UIRectEdgeTop) == UIRectEdgeTop) {
        if ((corner&UIRectCornerTopRight) == UIRectCornerTopRight) {
            secondTop = CGPointMake(size.width-radius.right, 0);
        }
        [path addLineToPoint:secondTop];
        if ((corner&UIRectCornerTopRight) == UIRectCornerTopRight) {
            [path addArcWithCenter:CGPointMake(size.width-radius.right, radius.right) radius:radius.right startAngle:-M_PI/2 endAngle:0 clockwise:YES];
        }
        
    }else{
        [path moveToPoint:secondTop];
    }
    CGPoint thirdRight = CGPointMake(size.width, size.height);
    if ((edge&UIRectEdgeRight) == UIRectEdgeRight) {
        if ((corner&UIRectCornerBottomRight) == UIRectCornerBottomRight) {
            thirdRight = CGPointMake(size.width, size.height-radius.bottom);
        }
        [path addLineToPoint:thirdRight];
        if ((corner&UIRectCornerBottomRight) == UIRectCornerBottomRight) {
            [path addArcWithCenter:CGPointMake(size.width-radius.bottom, size.height-radius.bottom) radius:radius.bottom startAngle:0 endAngle:M_PI/2 clockwise:YES];
        }
        
        
    }else{
        [path moveToPoint:thirdRight];
    }
    CGPoint fouthBottom = CGPointMake(0, size.height);
    if ((edge&UIRectEdgeBottom) == UIRectEdgeBottom) {
        if ((corner&UIRectCornerBottomLeft) == UIRectCornerBottomLeft) {
            fouthBottom = CGPointMake(radius.left, size.height);
        }
        [path addLineToPoint:fouthBottom];
        if ((corner&UIRectCornerBottomLeft) == UIRectCornerBottomLeft) {
            [path addArcWithCenter:CGPointMake(radius.left, size.height-radius.left) radius:radius.left startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
        }
        
    }else{
        [path moveToPoint:fouthBottom];
    }
    
    CGPoint firstLeft = CGPointZero;
    if ((edge&UIRectEdgeLeft) == UIRectEdgeLeft) {
        if ((corner&UIRectCornerTopLeft) == UIRectCornerTopLeft) {
            firstLeft = CGPointMake(0, radius.top);
        }
        [path addLineToPoint:firstLeft];
        if ((corner&UIRectCornerTopLeft) == UIRectCornerTopLeft) {
            [path addArcWithCenter:CGPointMake(radius.top, radius.top) radius:radius.top startAngle:M_PI endAngle:M_PI*1.5 clockwise:YES];
        }
    }else{
        [path moveToPoint:firstLeft];
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.lineWidth = width;
    layer.fillColor = DWJQCOLOR_CLEAR.CGColor;
    layer.strokeColor = color.CGColor;
    [self.layer addSublayer:layer];

}
+ (UIView *)copyView:(UIView *)view{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}
@end


