//
//  UIView+CHXChainAnimationProperty.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHXChainBlock.h"

@interface UIView (CHXChainAnimationProperty)

- (CHXChainableRect)makeFrame;
- (CHXChainableRect)makeBounds;
- (CHXChainableSize)makeSize;
- (CHXChainablePoint)makeOrigin;
- (CHXChainablePoint)makeCenter;
- (CHXChainableFloat)makeX;
- (CHXChainableFloat)makeY;
- (CHXChainableFloat)makeWidth;
- (CHXChainableFloat)makeHeight;
- (CHXChainableFloat)makeOpacity;
- (CHXChainableColor)makeBackground;
- (CHXChainableColor)makeBorderColor;
- (CHXChainableFloat)makeBorderWidth;
- (CHXChainableFloat)makeCornerRadius;
- (CHXChainableFloat)makeScale;
- (CHXChainableFloat)makeScaleX;
- (CHXChainableFloat)makeScaleY;
- (CHXChainablePoint)makeAnchor;
- (void)makeAnchorFromX:(CGFloat) x Y:(CGFloat)y;

@end
