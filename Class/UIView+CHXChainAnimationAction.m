//
//  UIView+CHXChainAnimationAction.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "UIView+CHXChainAnimationAction.h"
#import "UIView+CHXChainAnimationPrivate.h"
#import "UIView+CHXChainAnimationProperty.h"

CG_INLINE CGFloat degrees_to_radians(double d) {
    return (d / 180.0*M_PI);
}

static NSString *const kCHXAnimationKeyPathPosition = @"position";
static NSString *const kCHXAnimationKeyPathPositionX = @"position.x";
static NSString *const kCHXAnimationKeyPathPositionY = @"position.y";

static NSString *const kCHXAnimationKeyPathBounds = @"bounds.size";
static NSString *const kCHXAnimationKeyPathTransform = @"transform";
static NSString *const kCHXAnimationKeyPathTransformRotationZ = @"transform.rotation.z";


@implementation UIView (CHXChainAnimationAction)

- (CHXChainableFloat)moveX {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPositionX];
            positionAnimation.fromValue = @(weakSelf.layer.position.x);
            positionAnimation.toValue = @(weakSelf.layer.position.x+f);
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint position = weakSelf.layer.position;
            position.x += f;
            weakSelf.layer.position = position;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)moveY {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPositionY];
            positionAnimation.fromValue = @(weakSelf.layer.position.y);
            positionAnimation.toValue = @(weakSelf.layer.position.y+f);
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint position = weakSelf.layer.position;
            position.y += f;
            weakSelf.layer.position = position;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainablePoint)moveXY {
    CHXChainablePoint chainable = CHXChainablePoint(x, y) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *positionAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPosition];
            CGPoint oldOrigin = weakSelf.layer.frame.origin;
            CGPoint newPosition = [weakSelf newPositionFromNewOrigin:CGPointMake(oldOrigin.x+x, oldOrigin.y+y)];
            positionAnimation.fromValue = [NSValue valueWithCGPoint:weakSelf.layer.position];
            positionAnimation.toValue = [NSValue valueWithCGPoint:newPosition];
            [weakSelf addAnimationFromCalculationBlock:positionAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint position = weakSelf.layer.position;
            position.x +=x; position.y += y;
            weakSelf.layer.position = position;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)moveHeight {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathBounds];
            sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
            sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height+f, 0))];
            [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect bounds = CGRectMake(0, 0, weakSelf.bounds.size.width, MAX(weakSelf.bounds.size.height+f, 0));
            weakSelf.layer.bounds = bounds;
            weakSelf.bounds = bounds;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)moveWidth {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *sizeAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathBounds];
            sizeAnimation.fromValue = [NSValue valueWithCGSize:weakSelf.layer.bounds.size];
            sizeAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(MAX(weakSelf.bounds.size.width+f, 0), weakSelf.bounds.size.height)];
            [weakSelf addAnimationFromCalculationBlock:sizeAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGRect bounds = CGRectMake(0, 0, MAX(weakSelf.bounds.size.width+f, 0), weakSelf.bounds.size.height);
            weakSelf.layer.bounds = bounds;
            weakSelf.bounds = bounds;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainableDegrees)rotate {
    
    CHXChainableDegrees chainable = CHXChainableDegrees(angle) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *rotationAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransformRotationZ];
            CATransform3D transform = weakSelf.layer.transform;
            CGFloat originalRotation = atan2(transform.m12, transform.m11);
            rotationAnimation.fromValue = @(originalRotation);
            rotationAnimation.toValue = @(originalRotation+DegreesToRadians(angle));
            [weakSelf addAnimationFromCalculationBlock:rotationAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            CGFloat originalRotation = atan2(transform.m12, transform.m11);
            CATransform3D zRotation = CATransform3DMakeRotation(DegreesToRadians(angle)+originalRotation, 0, 0, 1.0);
            weakSelf.layer.transform = zRotation;
        }];
        
        return self;
    };
    return chainable;
}

- (CHXChainablePolarCoordinate)movePolar {
    CHXChainablePolarCoordinate chainable = CHXChainablePolarCoordinate(radius, angle) {
        CGFloat x = radius*cosf(DegreesToRadians(angle));
        CGFloat y = -radius*sinf(DegreesToRadians(angle));
        return self.moveXY(x, y);
    };
    return chainable;
}

// Transforms

- (UIView *)transformIdentity {
    [self addAnimationCalculationAction:^(UIView *weakSelf) {
        CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
        CATransform3D transform = CATransform3DIdentity;
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
        [weakSelf addAnimationFromCalculationBlock:transformAnimation];
    }];
    [self addAnimationCompletionAction:^(UIView *weakSelf) {
        CATransform3D transform = CATransform3DIdentity;
        weakSelf.layer.transform = transform;
    }];
    return self;
}

- (CHXChainableFloat)transformX {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, f, 0, 0);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, f, 0, 0);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)transformY {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, 0, f, 0);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, 0, f, 0);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)transformZ {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, 0, 0, f);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, 0, 0, f);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainablePoint)transformXY {
    CHXChainablePoint chainable = CHXChainablePoint(x, y) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, x, y, 0);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DTranslate(transform, x, y, 0);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)transformScale {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, f, f, 1);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, f, f, 1);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)transformScaleX {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, f, 1, 1);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, f, 1, 1);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableFloat)transformScaleY {
    CHXChainableFloat chainable = CHXChainableFloat(f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *transformAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathTransform];
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, 1, f, 1);
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:weakSelf.layer.transform];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
            [weakSelf addAnimationFromCalculationBlock:transformAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CATransform3D transform = weakSelf.layer.transform;
            transform = CATransform3DScale(transform, 1, f, 1);
            weakSelf.layer.transform = transform;
        }];
        return self;
    };
    return chainable;
}

// AutoLayout
- (CHXChainableLayoutConstraint)makeConstraint {
    CHXChainableLayoutConstraint chainable = CHXChainableLayoutConstraint(constraint, f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            if ([weakSelf.constraints containsObject:constraint]) {
                constraint.constant = f;
                [weakSelf setNeedsUpdateConstraints];
            }
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableLayoutConstraint)moveConstraint {
    CHXChainableLayoutConstraint chainable = CHXChainableLayoutConstraint(constraint, f) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            if ([weakSelf.constraints containsObject:constraint]) {
                constraint.constant += f;
                [weakSelf setNeedsUpdateConstraints];
            }
        }];
        return self;
    };
    return chainable;
}

// Bezier Paths
- (UIBezierPath *)bezierPathForAnimation {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.layer.position];
    return path;
}

- (CHXChainableBezierPath)moveOnPath {
    CHXChainableBezierPath chainable = CHXChainableBezierPath(path) {
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *pathAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPosition];
            pathAnimation.path = path.CGPath;
            [weakSelf addAnimationFromCalculationBlock:pathAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint endPoint = path.currentPoint;
            weakSelf.layer.position = endPoint;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableBezierPath)moveAndRotateOnPath {
    CHXChainableBezierPath chainable = CHXChainableBezierPath(path) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *pathAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPosition];
            pathAnimation.path = path.CGPath;
            pathAnimation.rotationMode = kCAAnimationRotateAuto;
            [weakSelf addAnimationFromCalculationBlock:pathAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint endPoint = path.currentPoint;
            weakSelf.layer.position = endPoint;
        }];
        return self;
    };
    return chainable;
}

- (CHXChainableBezierPath)moveAndReverseRotateOnPath {
    CHXChainableBezierPath chainable = CHXChainableBezierPath(path) {
        
        [self addAnimationCalculationAction:^(UIView *weakSelf) {
            CHXKeyframeAnimation *pathAnimation = [weakSelf basicAnimationForKeyPath:kCHXAnimationKeyPathPosition];
            pathAnimation.path = path.CGPath;
            pathAnimation.rotationMode = kCAAnimationRotateAutoReverse;
            [weakSelf addAnimationFromCalculationBlock:pathAnimation];
        }];
        [self addAnimationCompletionAction:^(UIView *weakSelf) {
            CGPoint endPoint = path.currentPoint;
            weakSelf.layer.position = endPoint;
        }];
        return self;
    };
    return chainable;
}

- (UIView *)anchorDefault {
    return self.anchorCenter;
}

- (UIView *)anchorCenter {
    
    [self makeAnchorFromX:0.5 Y:0.5];
    
    return self;
}

- (UIView *)anchorTopLeft {
    
    [self makeAnchorFromX:0.0 Y:0.0];
    
    return self;
}

- (UIView *)anchorTopRight {
    
    [self makeAnchorFromX:1.0 Y:0.0];
    
    return self;
}

- (UIView *)anchorBottomLeft {
    
    [self makeAnchorFromX:0.0 Y:1.0];
    
    return self;
}

- (UIView *)anchorBottomRight {
    
    [self makeAnchorFromX:1.0 Y:1.0];
    
    return self;
}

- (UIView *)anchorTop {
    
    [self makeAnchorFromX:0.5 Y:0.0];
    
    return self;
}

- (UIView *)anchorBottom {
    
    [self makeAnchorFromX:0.5 Y:1.0];
    
    return self;
}

- (UIView *)anchorLeft {
    
    [self makeAnchorFromX:0.0 Y:0.5];
    
    return self;
}

- (UIView *)anchorRight {
    
    [self makeAnchorFromX:1.0 Y:0.5];
    
    return self;
}

@end
