//
//  UIView+CHXChainAnimationTimingFunction.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHXChainBlock.h"

@interface UIView (CHXChainAnimationTimingFunction)

// Simple effects
- (UIView *)easeIn;
- (UIView *)easeOut;
- (UIView *)easeInOut;
- (UIView *)easeBack;
- (UIView *)spring;
- (UIView *)bounce;

// Animation Keyframe Calculation Functions
// Functions from https://github.com/NachoSoto/NSBKeyframeAnimation
// source: http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js
- (UIView *)easeInQuad;
- (UIView *)easeOutQuad;
- (UIView *)easeInOutQuad;
- (UIView *)easeInCubic;
- (UIView *)easeOutCubic;
- (UIView *)easeInOutCubic;
- (UIView *)easeInQuart;
- (UIView *)easeOutQuart;
- (UIView *)easeInOutQuart;
- (UIView *)easeInQuint;
- (UIView *)easeOutQuint;
- (UIView *)easeInOutQuint;
- (UIView *)easeInSine;
- (UIView *)easeOutSine;
- (UIView *)easeInOutSine;
- (UIView *)easeInExpo;
- (UIView *)easeOutExpo;
- (UIView *)easeInOutExpo;
- (UIView *)easeInCirc;
- (UIView *)easeOutCirc;
- (UIView *)easeInOutCirc;
- (UIView *)easeInElastic;
- (UIView *)easeOutElastic;
- (UIView *)easeInOutElastic;
- (UIView *)easeInBack;
- (UIView *)easeOutBack;
- (UIView *)easeInOutBack;
- (UIView *)easeInBounce;
- (UIView *)easeOutBounce;
- (UIView *)easeInOutBounce;

#pragma mark - Multiple Animation Chaining
- (CHXChainableTimeInterval)thenAfter;

#pragma mark - Animations
- (CHXChainableTimeInterval)delay;
- (CHXChainableTimeInterval)wait; // same as delay

// Executors
- (CHXChainableAnimation)animate;
- (CHXChainableAnimationWithCompletion)animateWithCompletion;
@end
