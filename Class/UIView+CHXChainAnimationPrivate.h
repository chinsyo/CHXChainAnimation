//
//  UIView+CHXChainAnimationPrivate.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHXKeyframeAnimation.h"
#import "CHXChainBlock.h"

typedef void (^CHXAnimationCalculationAction)(UIView *weakSelf);
typedef void (^CHXAnimationCompletionAction)(UIView *weakSelf);

@interface UIView (CHXChainAnimationPrivate)

// Arrays of animations to be grouped
@property (strong, nonatomic) NSMutableArray *CHXAnimations;

// Grouped animations
@property (strong, nonatomic) NSMutableArray *CHXAnimationGroups;

// Code run at the beginning of an animation link to calculate values
@property (strong, nonatomic) NSMutableArray *CHXAnimationCalculationActions;

// Code run after animation is completed
@property (strong, nonatomic) NSMutableArray *CHXAnimationCompletionActions;

@property (nonatomic, copy) CHXAnimationCompletion animationCompletion;

// Methods
- (void)clear;

- (void)setAnimationCompletion:(CHXAnimationCompletion)animationCompletion;

- (CAAnimationGroup *)basicAnimationGroup;

- (CHXKeyframeAnimation *)basicAnimationForKeyPath:(NSString *) keypath;

- (void)addAnimation:(CHXKeyframeAnimation *) animation;

- (void)addAnimationFromCalculationBlock:(CHXKeyframeAnimation *) animation;

- (CGPoint)newPositionFromNewFrame:(CGRect)newRect;

- (CGPoint)newPositionFromNewOrigin:(CGPoint)newOrigin;

- (CGPoint)newPositionFromNewCenter:(CGPoint)newCenter;

- (void)addAnimationCalculationAction:(CHXAnimationCalculationAction)action;

- (void)addAnimationCompletionAction:(CHXAnimationCompletionAction)action;

@end
