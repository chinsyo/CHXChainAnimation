//
//  UIView+CHXChainAnimationProperty.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "UIView+CHXChainAnimationProperty.h"
#import "UIView+CHXChainAnimationPrivate.h"
#import "CHXKeyframeAnimation.h"

@implementation UIView (CHXChainAnimationProperty)

- (CHXChainableRect)makeFrame {
    CHXChainableRect chainable = CHXChainableRect(rect) {
        
        return self.makeOrigin(rect.origin.x, rect.origin.y).makeBounds(rect);
    };
    
    return chainable;
}

- (CHXChainableRect)makeBounds {
    CHXChainableRect chainable = CHXChainableRect(rect) {
        
        return self.makeSize(rect.size.width, rect.size.height);
    };
    return chainable;
}

- (CHXChainableSize)makeSize {
    CHXChainableSize chainable = CHXChainableSize(width, height) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:@"bounds.size"];
            sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
            sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(width, height)];
            [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect bounds = CGRectMake(0, 0, width, height);
            weakSelf.layer.bounds = bounds;
            weakSelf.bounds = bounds;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainablePoint)makeOrigin {
    CHXChainablePoint chainable = CHXChainablePoint(x, y) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position"];
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(x, y)];
            positionAnimation.fromValue = [NSValue valueWithCGPoint:weakSelf.layer.position];
            positionAnimation.toValue = [NSValue valueWithCGPoint:newPosition];
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(x, y)];
            weakSelf.layer.position = newPosition;
        }];
        
        return self;
    };
    return chainable;
}


- (CHXChainablePoint)makeCenter {
    CHXChainablePoint chainable = CHXChainablePoint(x, y) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position"];
            CGPoint newPosition = [weakSelf newPositionFromNewCenter:CGPointMake(x, y)];
            positionAnimation.fromValue = [NSValue valueWithCGPoint:weakSelf.layer.position];
            positionAnimation.toValue = [NSValue valueWithCGPoint:newPosition];
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.center = CGPointMake(x, y);
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeX {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position.x"];
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(f, weakSelf.layer.frame.origin.y)];
            positionAnimation.fromValue = @(weakSelf.layer.position.x);
            positionAnimation.toValue = @(newPosition.x);
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(f, weakSelf.layer.frame.origin.y)];
            weakSelf.layer.position = newPosition;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeY {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:@"position.y"];
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(weakSelf.layer.frame.origin.x, f)];
            positionAnimation.fromValue = @(weakSelf.layer.position.y);
            positionAnimation.toValue = @(newPosition.y);
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(weakSelf.layer.frame.origin.x, f)];
            weakSelf.layer.position = newPosition;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeWidth {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:@"bounds.size"];
            sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
            sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(f, weakSelf.frame.size.height)];
            [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect bounds = CGRectMake(0, 0, f, weakSelf.frame.size.height);
            weakSelf.layer.bounds = bounds;
            weakSelf.bounds = bounds;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeHeight {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:@"bounds.size"];
            sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
            sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(weakSelf.frame.size.width, f)];
            [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect bounds = CGRectMake(0, 0, weakSelf.frame.size.width, f);
            weakSelf.layer.bounds = bounds;
            weakSelf.bounds = bounds;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeOpacity {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *opacityAnimation = [weakSelf basicAnimationForKeyPath:@"opacity"];
            opacityAnimation.fromValue = @(weakSelf.alpha);
            opacityAnimation.toValue = @(f);
            [weakSelf addAnimationFromCalculationBlock:opacityAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.alpha = f;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableColor)makeBackground {
    CHXChainableColor chainable = CHXChainableColor(color) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *colorAnimation = [weakSelf basicAnimationForKeyPath:@"backgroundColor"];
            colorAnimation.fromValue = weakSelf.backgroundColor;
            colorAnimation.toValue = color;
            [weakSelf addAnimationFromCalculationBlock:colorAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.layer.backgroundColor = color.CGColor;
            weakSelf.backgroundColor = color;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableColor)makeBorderColor {
    CHXChainableColor chainable = CHXChainableColor(color) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *colorAnimation = [weakSelf basicAnimationForKeyPath:@"borderColor"];
            UIColor *borderColor = (__bridge UIColor*)(weakSelf.layer.borderColor);
            colorAnimation.fromValue = borderColor;
            colorAnimation.toValue = color;
            [weakSelf addAnimationFromCalculationBlock:colorAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.layer.borderColor = color.CGColor;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeBorderWidth {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        f = MAX(0, f);
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *borderAnimation = [weakSelf basicAnimationForKeyPath:@"borderWidth"];
            borderAnimation.fromValue = @(weakSelf.layer.borderWidth);
            borderAnimation.toValue = @(f);
            [weakSelf addAnimationFromCalculationBlock:borderAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.layer.borderWidth = f;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeCornerRadius {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        f = MAX(0, f);
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *cornerAnimation = [weakSelf basicAnimationForKeyPath:@"cornerRadius"];
            cornerAnimation.fromValue = @(weakSelf.layer.cornerRadius);
            cornerAnimation.toValue = @(f);
            [weakSelf addAnimationFromCalculationBlock:cornerAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            weakSelf.layer.cornerRadius = f;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeScale {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *boundsAnimation = [weakSelf basicAnimationForKeyPath:@"bounds"];
            CGRect rect = CGRectMake(0, 0, MAX(weakSelf.bounds.size.width*f, 0), MAX(weakSelf.bounds.size.height*f, 0));
            boundsAnimation.fromValue = [NSValue valueWithCGRect:weakSelf.layer.bounds];
            boundsAnimation.toValue = [NSValue valueWithCGRect:rect];
            [weakSelf addAnimationFromCalculationBlock:boundsAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect rect = CGRectMake(0, 0, MAX(weakSelf.bounds.size.width*f, 0), MAX(weakSelf.bounds.size.height*f, 0));
            weakSelf.layer.bounds = rect;
            weakSelf.bounds = rect;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeScaleX {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *boundsAnimation = [weakSelf basicAnimationForKeyPath:@"bounds"];
            CGRect rect = CGRectMake(0, 0, MAX(weakSelf.bounds.size.width*f, 0), weakSelf.bounds.size.height);
            boundsAnimation.fromValue = [NSValue valueWithCGRect:weakSelf.layer.bounds];
            boundsAnimation.toValue = [NSValue valueWithCGRect:rect];
            [weakSelf addAnimationFromCalculationBlock:boundsAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect rect = CGRectMake(0, 0, MAX(weakSelf.bounds.size.width*f, 0), weakSelf.bounds.size.height);
            weakSelf.layer.bounds = rect;
            weakSelf.bounds = rect;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)makeScaleY {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *boundsAnimation = [weakSelf basicAnimationForKeyPath:@"bounds"];
            CGRect rect = CGRectMake(0, 0, weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height*f, 0));
            boundsAnimation.fromValue = [NSValue valueWithCGRect:weakSelf.layer.bounds];
            boundsAnimation.toValue = [NSValue valueWithCGRect:rect];
            [weakSelf addAnimationFromCalculationBlock:boundsAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect rect = CGRectMake(0, 0, weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height*f, 0));
            weakSelf.layer.bounds = rect;
            weakSelf.bounds = rect;
        }];
        
        return self;
    };
    return chainable;
}

- (void)makeAnchorFromX:(CGFloat) x Y:(CGFloat)y {
    CHXAnimationCalculationAction action = ^void(UIView *weakSelf) {
        CGPoint anchorPoint = CGPointMake(x, y);
        if (CGPointEqualToPoint(anchorPoint, weakSelf.layer.anchorPoint)) {
            return;
        }
        CGPoint newPoint = CGPointMake(weakSelf.bounds.size.width * anchorPoint.x,
                                       weakSelf.bounds.size.height * anchorPoint.y);
        CGPoint oldPoint = CGPointMake(weakSelf.bounds.size.width * weakSelf.layer.anchorPoint.x,
                                       weakSelf.bounds.size.height * weakSelf.layer.anchorPoint.y);
        
        newPoint = CGPointApplyAffineTransform(newPoint, weakSelf.transform);
        oldPoint = CGPointApplyAffineTransform(oldPoint, weakSelf.transform);
        
        CGPoint position = weakSelf.layer.position;
        
        position.x -= oldPoint.x;
        position.x += newPoint.x;
        
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        weakSelf.layer.position = position;
        weakSelf.layer.anchorPoint = anchorPoint;
    };
    NSMutableArray *lastCalculationActions = [self.CHXAnimationCalculationActions lastObject];
    [lastCalculationActions insertObject:action atIndex:0];
}

- (CHXChainablePoint)makeAnchor {
    CHXChainablePoint chainable = CHXChainablePoint(x, y) {
        
        [self makeAnchorFromX:x Y:y];
        
        return self;
    };
    return chainable;
}


@end
