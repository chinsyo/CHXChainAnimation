//
//  UIView+CHXChainAnimationTimingFunction.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "UIView+CHXChainAnimationTimingFunction.h"
#import "UIView+CHXChainAnimationPrivate.h"
#import "UIView+CHXChainAnimationProperty.h"
#import "CHXKeyframeAnimation.h"
#import "CHXChainAnimationBlock.h"

#import "NSBKeyframeAnimationFunctions.h"

static NSString *const kCHXChainAnimationKeyAnimationChain = @"AnimationChain";

@implementation UIView (CHXChainAnimationTimingFunction)

- (void)addAnimationKeyframeCalculation:(NSBKeyframeAnimationFunctionBlock) functionBlock {
    [self addAnimationCalculationAction:^(UIView *weakSelf) {
        NSMutableArray *animationCluster = [weakSelf.CHXAnimations firstObject];
        CHXKeyframeAnimation *animation = [animationCluster lastObject];
        animation.functionBlock = functionBlock;
    }];
}

- (UIView *)easeIn {
    return [self easeInQuad];
}

- (UIView *)easeOut {
    return [self easeOutQuad];
}

- (UIView *)easeInOut {
    return [self easeInOutQuad];
}

- (UIView *)easeBack {
    return [self easeOutBack];
}

- (UIView *)spring {
    return [self easeOutElastic];
}

- (UIView *)bounce {
    return [self easeOutBounce];
}


- (UIView *)easeInQuad {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInQuad(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutQuad {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutQuad(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutQuad {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutQuad(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInCubic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInCubic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutCubic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutCubic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutCubic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutCubic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInQuart {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInQuart(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutQuart {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutQuart(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutQuart {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutQuart(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInQuint {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInQuint(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutQuint {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutQuint(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutQuint {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutQuint(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInSine {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInSine(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutSine {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutSine(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutSine {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutSine(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInExpo {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInExpo(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutExpo {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutExpo(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutExpo {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutExpo(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInCirc {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInCirc(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutCirc {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutCirc(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutCirc {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutCirc(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInElastic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInElastic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutElastic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutElastic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutElastic {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutElastic(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInBack {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInBack(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutBack {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutBack(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutBack {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutBack(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInBounce {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInBounce(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeOutBounce {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseOutBounce(t, b, c, d);
    }];
    return self;
}

- (UIView *)easeInOutBounce {
    [self addAnimationKeyframeCalculation:^double(double t, double b, double c, double d) {
        return NSBKeyframeAnimationFunctionEaseInOutBounce(t, b, c, d);
    }];
    return self;
}

#pragma mark - Semantics (Easier to read)

- (UIView *)seconds {
    return self;
}

#pragma mark - Multiple Animation Chaining

- (CHXChainableTimeInterval)thenAfter {
    
    CHXChainableTimeInterval chainable = CHXChainableTimeInterval(t) {
        
        CAAnimationGroup *group = [self.CHXAnimationGroups lastObject];
        group.duration = t;
        CAAnimationGroup *newGroup = [self basicAnimationGroup];
        [self.CHXAnimationGroups addObject:newGroup];
        [self.CHXAnimations addObject:[NSMutableArray array]];
        [self.CHXAnimationCompletionActions addObject:[NSMutableArray array]];
        [self.CHXAnimationCalculationActions addObject:[NSMutableArray array]];
        
        return self;
    };
    
    return chainable;
}

- (CAAnimationGroup *)basicAnimationGroup {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    return group;
}

- (CHXChainableTimeInterval)delay {
    CHXChainableTimeInterval chainable = CHXChainableTimeInterval(t) {
        
        for (CAAnimation *aGroup in self.CHXAnimationGroups) {
            t+=aGroup.duration;
        }
        CAAnimationGroup *group = [self.CHXAnimationGroups lastObject];
        group.beginTime = CACurrentMediaTime() + t;
        
        return self;
    };
    return chainable;
}

- (CHXChainableTimeInterval)wait {
    CHXChainableTimeInterval chainable = CHXChainableTimeInterval(t) {
        
        return self.delay(t);
    };
    return chainable;
}

- (void) animateChain {
    [self sanityCheck];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setCompletionBlock:^{
        [self.layer removeAnimationForKey:kCHXChainAnimationKeyAnimationChain];
        [self chainLinkDidFinishAnimating];
    }];
    
    [self animateChainLink];
    
    [CATransaction commit];
    
    [self executeCompletionActions];
}

- (void)executeCompletionActions {
    CAAnimationGroup *group = [self.CHXAnimationGroups firstObject];
    NSTimeInterval delay = MAX(group.beginTime - CACurrentMediaTime(), 0.0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *actionCluster = [self.CHXAnimationCompletionActions firstObject];
        for (CHXAnimationCompletionAction action in actionCluster) {
            __weak UIView *weakSelf = self;
            action(weakSelf);
        }
    });
}

- (void)chainLinkDidFinishAnimating {
    [self.CHXAnimationCompletionActions removeObjectAtIndex:0];
    [self.CHXAnimationCalculationActions removeObjectAtIndex:0];
    [self.CHXAnimations removeObjectAtIndex:0];
    [self.CHXAnimationGroups removeObjectAtIndex:0];
    [self sanityCheck];
    if (self.CHXAnimationGroups.count == 0) {
        [self clear];
        if (self.animationCompletion) {
            CHXAnimationCompletion completion = self.animationCompletion;
            self.animationCompletion = nil;
            completion();
        }
    } else {
        [self animateChain];
    }
}

- (void)animateChainLink {
    [self makeAnchorFromX:0.5 Y:0.5];
    NSMutableArray *actionCluster = [self.CHXAnimationCalculationActions firstObject];
    for (CHXAnimationCalculationAction action in actionCluster) {
        __weak UIView *weakSelf = self;
        action(weakSelf);
    }
    CAAnimationGroup *group = [self.CHXAnimationGroups firstObject];
    NSMutableArray *animationCluster = [self.CHXAnimations firstObject];
    for (CHXKeyframeAnimation *animation in animationCluster) {
        animation.duration = group.duration;
        [animation calculate];
    }
    group.animations = animationCluster;
    [self.layer addAnimation:group forKey:kCHXChainAnimationKeyAnimationChain];
    
    // For constraints
    NSTimeInterval delay = MAX(group.beginTime - CACurrentMediaTime(), 0.0);
    [self.class animateWithDuration:group.duration
                              delay:delay
                            options:0
                         animations:^{
                             [self updateConstraints];
                         } completion:NULL];
}

- (CHXChainableAnimation)animate {
    CHXChainableAnimation chainable = CHXChainableAnimation(duration) {
        
        CAAnimationGroup *group = [self.CHXAnimationGroups lastObject];
        group.duration = duration;
        [self animateChain];
        
        return self;
    };
    return chainable;
}

- (CHXChainableAnimationWithCompletion)animateWithCompletion {
    CHXChainableAnimationWithCompletion chainable = CHXChainableAnimationWithCompletion(duration, completion) {
        
        CAAnimationGroup *group = [self.CHXAnimationGroups lastObject];
        group.duration = duration;
        self.animationCompletion = completion;
        [self animateChain];
        
        return self;
    };
    return chainable;
}

- (void)sanityCheck {
    NSAssert(self.CHXAnimations.count == self.CHXAnimationGroups.count, @"FATAL ERROR: ANIMATION GROUPS AND ANIMATIONS ARE OUT OF SYNC");
    NSAssert(self.CHXAnimationCalculationActions.count == self.CHXAnimationCompletionActions.count, @"FATAL ERROR: ANIMATION CALCULATION OBJECTS AND ANIMATION COMPLETION OBJECTS ARE OUT OF SYNC");
    NSAssert(self.CHXAnimations.count == self.CHXAnimationCompletionActions.count, @"FATAL ERROR: ANIMATIONS AND ANIMATION COMPLETION OBJECTS  ARE OUT OF SYNC");
}

@end
