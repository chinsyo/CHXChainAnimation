//
//  UIView+CHXChainAnimationAction.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHXChainAnimationBlock.h"

@interface UIView (CHXChainAnimationAction)

// Movers
// Affects views position and bounds
- (CHXChainableFloat)moveX;
- (CHXChainableFloat)moveY;
- (CHXChainablePoint)moveXY;
- (CHXChainableFloat)moveHeight;
- (CHXChainableFloat)moveWidth;
- (CHXChainablePolarCoordinate)movePolar;

// Transforms
// Affects views transform property NOT position and bounds
// These should be used for AutoLayout
// These should NOT be mixed with properties that affect position and bounds
- (UIView *)transformIdentity;
- (CHXChainableDegrees)rotate;
- (CHXChainableFloat)transformX;
- (CHXChainableFloat)transformY;
- (CHXChainableFloat)transformZ;
- (CHXChainablePoint)transformXY;
- (CHXChainableFloat)transformScale; // x and y equal
- (CHXChainableFloat)transformScaleX;
- (CHXChainableFloat)transformScaleY;

// AutoLayout
// Affects constants of constraints
- (CHXChainableLayoutConstraint)makeConstraint;
- (CHXChainableLayoutConstraint)moveConstraint;

// Bezier Paths
// Animation effects dont apply
- (CHXChainableBezierPath)moveOnPath;
- (CHXChainableBezierPath)moveAndRotateOnPath;
- (CHXChainableBezierPath)moveAndReverseRotateOnPath;

// A bezier path starting from the views layers position
// Not a chainable property
- (UIBezierPath *)bezierPathForAnimation;

// Anchors
- (UIView *)anchorDefault;
- (UIView *)anchorCenter;
- (UIView *)anchorTopLeft;
- (UIView *)anchorTopRight;
- (UIView *)anchorBottomLeft;
- (UIView *)anchorBottomRight;
- (UIView *)anchorTop;
- (UIView *)anchorBottom;
- (UIView *)anchorLeft;
- (UIView *)anchorRight;

@end
