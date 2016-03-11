//
//  CHXChainBlock.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef CHXChainBlock_h
#define CHXChainBlock_h

typedef UIView* (^CHXChainable)();
#define CHXChainable() ^UIView*()

typedef UIView* (^CHXChainableTimeInterval)(NSTimeInterval t);
#define CHXChainableTimeInterval(t) ^UIView* (NSTimeInterval t)

typedef UIView* (^CHXChainableRect)(CGRect rect);
#define CHXChainableRect(rect) ^UIView* (CGRect rect)

typedef UIView* (^CHXChainableSize)(CGFloat width, CGFloat height);
#define CHXChainableSize(width, height) ^UIView* (CGFloat width, CGFloat height)

typedef UIView* (^CHXChainablePoint)(CGFloat x, CGFloat y);
#define CHXChainablePoint(x,y) ^UIView* (CGFloat x, CGFloat y)

typedef UIView* (^CHXChainableFloat)(CGFloat f);
#define CHXChainableFloat(f) ^UIView* (CGFloat f)

typedef UIView* (^CHXChainableDegrees)(CGFloat angle);
#define CHXChainableDegrees(angle) ^UIView* (CGFloat angle)

typedef UIView* (^CHXChainablePolarCoordinate)(CGFloat radius, CGFloat angle);
#define CHXChainablePolarCoordinate(radius, angle) ^UIView* (CGFloat radius, CGFloat angle)

typedef UIView* (^CHXChainableColor)(UIColor* color);
#define CHXChainableColor(color) ^UIView* (UIColor *color)

typedef UIView* (^CHXChainableLayoutConstraint)(NSLayoutConstraint *constraint, CGFloat f);
#define CHXChainableLayoutConstraint(constraint, f) ^UIView*(NSLayoutConstraint *constraint, CGFloat f)

typedef UIView* (^CHXChainableBezierPath)(UIBezierPath *path);
#define CHXChainableBezierPath(path) ^UIView* (UIBezierPath *path)

typedef void (^CHXAnimationCompletion)();
#define CHXAnimationCompletion() ^void ()

typedef UIView* (^CHXChainableAnimation)(NSTimeInterval duration);
#define CHXChainableAnimation(duration) ^UIView* (NSTimeInterval duration)

typedef UIView* (^CHXChainableAnimationWithCompletion)(NSTimeInterval duration, CHXAnimationCompletion completion);
#define CHXChainableAnimationWithCompletion(duration, completion) ^UIView* (NSTimeInterval duration, CHXAnimationCompletion completion)

#endif /* CHXChainBlock_h */
