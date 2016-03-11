//
//  UIView+CHXChainAnimationPrivate.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "UIView+CHXChainAnimationPrivate.h"
#import <objc/runtime.h>

@implementation UIView (CHXChainAnimationPrivate)

- (void)setCHXAnimations:(NSMutableArray *)animations {
    objc_setAssociatedObject(self, @selector(CHXAnimations), animations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCHXAnimationGroups:(NSMutableArray *)animationGroups {
    objc_setAssociatedObject(self, @selector(CHXAnimationGroups), animationGroups, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCHXAnimationCalculationActions:(NSMutableArray *)animationCalculationActions {
    objc_setAssociatedObject(self, @selector(CHXAnimationCalculationActions), animationCalculationActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCHXAnimationCompletionActions:(NSMutableArray *)animationCompletionActions {
    objc_setAssociatedObject(self, @selector(CHXAnimationCompletionActions), animationCompletionActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAnimationCompletion:(CHXAnimationCompletion)animationCompletion {
    objc_setAssociatedObject(self, @selector(animationCompletion), animationCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableArray *)CHXAnimations {
    NSMutableArray *animations = objc_getAssociatedObject(self, @selector(CHXAnimations));
    if (animations == nil) {
        animations = [NSMutableArray arrayWithObject:[NSMutableArray array]];
        [self setCHXAnimations:animations];
    }
    return animations;
}

- (NSMutableArray *)CHXAnimationGroups {
    NSMutableArray *animationGroups = objc_getAssociatedObject(self, @selector(CHXAnimationGroups));
    if (animationGroups == nil) {
        animationGroups = [NSMutableArray arrayWithObject:[self basicAnimationGroup]];
        [self setCHXAnimationGroups:animationGroups];
    }
    return animationGroups;
}

- (NSMutableArray *)CHXAnimationCalculationActions {
    NSMutableArray *animationCalculationActions = objc_getAssociatedObject(self, @selector(CHXAnimationCalculationActions));
    if (animationCalculationActions == nil) {
        animationCalculationActions = [NSMutableArray arrayWithObject:[NSMutableArray array]];
        [self setCHXAnimationCalculationActions:animationCalculationActions];
    }
    return animationCalculationActions;
}

- (NSMutableArray *)CHXAnimationCompletionActions {
    NSMutableArray *animationCompletionActions = objc_getAssociatedObject(self, @selector(CHXAnimationCompletionActions));
    if (animationCompletionActions == nil) {
        animationCompletionActions = [NSMutableArray arrayWithObject:[NSMutableArray array]];;
        [self setCHXAnimationCompletionActions:animationCompletionActions];
    }
    return animationCompletionActions;
}

- (CHXAnimationCompletion)animationCompletion {
    return objc_getAssociatedObject(self, @selector(animationCompletion));
}


- (void)clear {
    [self.CHXAnimations removeAllObjects];
    [self.CHXAnimationGroups removeAllObjects];
    [self.CHXAnimationCompletionActions removeAllObjects];
    [self.CHXAnimationCalculationActions removeAllObjects];
    [self.CHXAnimations addObject:[NSMutableArray array]];
    [self.CHXAnimationCompletionActions addObject:[NSMutableArray array]];
    [self.CHXAnimationCalculationActions addObject:[NSMutableArray array]];
    [self.CHXAnimationGroups addObject:[self basicAnimationGroup]];
}

- (CAAnimationGroup *)basicAnimationGroup {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    return group;
}

- (CHXKeyframeAnimation *)basicAnimationForKeyPath:(NSString *)keypath {
    CHXKeyframeAnimation * animation = [CHXKeyframeAnimation animationWithKeyPath:keypath];
    animation.repeatCount = 0;
    animation.autoreverses = NO;
    return animation;
}

- (void)addAnimationFromCalculationBlock:(CHXKeyframeAnimation *)animation {
    NSMutableArray *animationCluster = [self.CHXAnimations firstObject];
    [animationCluster addObject:animation];
}

- (void)addAnimation:(CHXKeyframeAnimation *)animation {
    NSMutableArray *animationCluster = [self.CHXAnimations lastObject];
    [animationCluster addObject:animation];
}

- (void)addAnimationCalculationAction:(CHXAnimationCalculationAction)action {
    NSMutableArray *actions = [self.CHXAnimationCalculationActions lastObject];
    [actions addObject:action];
}

- (void)addAnimationCompletionAction:(CHXAnimationCompletionAction)action {
    NSMutableArray *actions = [self.CHXAnimationCompletionActions lastObject];
    [actions addObject:action];
}

- (CGPoint)newPositionFromNewFrame:(CGRect)newRect {
    CGPoint anchor = self.layer.anchorPoint;
    CGSize size = newRect.size;
    CGPoint newPosition;
    newPosition.x = newRect.origin.x + anchor.x*size.width;
    newPosition.y = newRect.origin.y + anchor.y*size.height;
    return newPosition;
}

- (CGPoint)newPositionFromNewOrigin:(CGPoint)newOrigin {
    CGPoint anchor = self.layer.anchorPoint;
    CGSize size = self.bounds.size;
    CGPoint newPosition;
    newPosition.x = newOrigin.x + anchor.x*size.width;
    newPosition.y = newOrigin.y + anchor.y*size.height;
    return newPosition;
}

- (CGPoint)newPositionFromNewCenter:(CGPoint)newCenter {
    CGPoint anchor = self.layer.anchorPoint;
    CGSize size = self.bounds.size;
    CGPoint newPosition;
    newPosition.x = newCenter.x + (anchor.x-0.5)*size.width;
    newPosition.y = newCenter.y + (anchor.y-0.5)*size.height;
    return newPosition;
}

@end
