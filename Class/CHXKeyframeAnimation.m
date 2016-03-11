//
//  CHXKeyframeAnimation.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXKeyframeAnimation.h"
#import <objc/runtime.h>

#define CHX_ARR_FOR(v) [self valuesArrayForStartValue:fromTransform.v endValue:toTransform.v]

static const NSInteger kCHXAnimationFPS = 60;
static const NSInteger kCHXAnimationConstant = 1000;

@interface CHXKeyframeAnimation ()

- (void)createValuesArray;

- (NSArray *)valuesArrayForStartValue:(CGFloat)startValue endValue:(CGFloat)endValue;

static CGPathRef CreatePathFromXYValues(NSArray *xValues,
                                        NSArray* yValues);

static NSArray* CreateRectArrayFrom(NSArray *xValues,
                                    NSArray *yValues,
                                    NSArray *widths,
                                    NSArray *heights);

static NSArray* CreateColorsArrayFrom(NSArray *redValues,
                                      NSArray *greenValues,
                                      NSArray *blueValues,
                                      NSArray *alphaValues);

static NSArray* CreateTransformArrayFrom(NSArray *M11,
                                         NSArray *M12,
                                         NSArray *M13,
                                         NSArray *M14,
                                         NSArray *M21,
                                         NSArray *M22,
                                         NSArray *M23,
                                         NSArray *M24,
                                         NSArray *M31,
                                         NSArray *M32,
                                         NSArray *M33,
                                         NSArray *M34,
                                         NSArray *M41,
                                         NSArray *M42,
                                         NSArray *M43,
                                         NSArray *M44);


@end

@implementation CHXKeyframeAnimation

+ (instancetype)animationWithKeyPath:(NSString *)path {
    
    CHXKeyframeAnimation *animation = [super animationWithKeyPath:path];
    if (animation) {
        animation.functionBlock = ^double(double t, double b, double c, double d) {
            return NSBKeyframeAnimationFunctionLinear(t, b, c, d);
        };
    }
    return animation;
}

- (void)calculate {
    [self createValuesArray];
}

- (void)createValuesArray {
    
    if (!(self.fromValue || self.toValue || self.duration)) {
        return;
    }
    
    if (object_getClassName(self.fromValue) != object_getClassName(self.toValue)) {
        return;
    }

    if ([self.fromValue isKindOfClass:[NSNumber class]]) {
        
        self.values = [self valuesArrayForStartValue:[self.fromValue doubleValue] endValue:[self.toValue doubleValue]];
        
    } else if ([self.fromValue isKindOfClass:[UIColor class]]) {
        
        const CGFloat *fromComponents = CGColorGetComponents(((UIColor*)self.fromValue).CGColor);
        const CGFloat *toComponents = CGColorGetComponents(((UIColor*)self.toValue).CGColor);
        NSArray *redValues = [self valuesArrayForStartValue:fromComponents[0] endValue:toComponents[0]];
        NSArray *greenValues = [self valuesArrayForStartValue:fromComponents[1] endValue:toComponents[1]];
        NSArray *blueValues = [self valuesArrayForStartValue:fromComponents[2] endValue:toComponents[2]];
        NSArray *alphaValues = [self valuesArrayForStartValue:fromComponents[3] endValue:toComponents[3]];
        
        self.values = CreateColorsArrayFrom(redValues, greenValues, blueValues, alphaValues);
        
    } else if ([self.fromValue isKindOfClass:[NSValue class]]) {
        
        NSString *valueType = [NSString stringWithCString:[self.fromValue objCType] encoding:NSStringEncodingConversionAllowLossy];
        
        if ([valueType containsString:@"CGPoint"]) {
            
            CGPoint fromPoint = [self.fromValue CGPointValue];
            CGPoint toPoint = [self.toValue CGPointValue];
            NSArray *xValues = [self valuesArrayForStartValue:fromPoint.x endValue:toPoint.x];
            NSArray *yValues = [self valuesArrayForStartValue:fromPoint.y endValue:toPoint.y];
            CGPathRef path = CreatePathFromXYValues(xValues, yValues);
            
            self.path = path;
            CGPathRelease(path);
            
        } else if ([valueType containsString:@"CGSize"]) {
            
            CGSize fromSize = [self.fromValue CGSizeValue];
            CGSize toSize = [self.toValue CGSizeValue];
            
            NSArray *xValues = [self valuesArrayForStartValue:fromSize.width endValue:toSize.width];
            NSArray *yValues = [self valuesArrayForStartValue:fromSize.height endValue:toSize.height];
            CGPathRef path = CreatePathFromXYValues(xValues, yValues);
            
            self.path = path;
            CGPathRelease(path);
            
        } else if ([valueType containsString:@"CGRect"]) {
            
            CGRect fromRect = [self.fromValue CGRectValue];
            CGRect toRect = [self.toValue CGRectValue];
            
            NSArray *xValues = [self valuesArrayForStartValue:fromRect.origin.x endValue:toRect.origin.x];
            NSArray *yValues = [self valuesArrayForStartValue:fromRect.origin.y endValue:toRect.origin.y];
            NSArray *widths = [self valuesArrayForStartValue:fromRect.size.width endValue:toRect.size.width];
            NSArray *heights = [self valuesArrayForStartValue:fromRect.size.height endValue:toRect.size.height];
            
            self.values = CreateRectArrayFrom(xValues, yValues, widths, heights);
            
            
        } else if ([valueType containsString:@"CATransform3D"]) {
            
            CATransform3D fromTransform = [self.fromValue transform3D];
            CATransform3D toTransform = [self.toValue transform3D];
            
            self.values = CreateTransformArrayFrom(CHX_ARR_FOR(m11),
                                                   CHX_ARR_FOR(m12),
                                                   CHX_ARR_FOR(m13),
                                                   CHX_ARR_FOR(m14),
                                                   CHX_ARR_FOR(m21),
                                                   CHX_ARR_FOR(m22),
                                                   CHX_ARR_FOR(m23),
                                                   CHX_ARR_FOR(m24),
                                                   CHX_ARR_FOR(m31),
                                                   CHX_ARR_FOR(m32),
                                                   CHX_ARR_FOR(m33),
                                                   CHX_ARR_FOR(m34),
                                                   CHX_ARR_FOR(m41),
                                                   CHX_ARR_FOR(m42),
                                                   CHX_ARR_FOR(m43),
                                                   CHX_ARR_FOR(m44));
        }
    }
}

- (NSArray *)valuesArrayForStartValue:(CGFloat)startValue endValue:(CGFloat)endValue {
    
    NSInteger steps = ceil(kCHXAnimationFPS * self.duration) + 2;
    NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:steps];
    
    CGFloat increment = 1.0/(CGFloat)(steps - 1);
    CGFloat progress = 0.0;
    CGFloat variable = 0.0;
    CGFloat value = 0.0;
    
    for (NSInteger index = 0; index < steps; index++) {
        variable = self.functionBlock(self.duration * progress * kCHXAnimationConstant, 0, 1, self.duration * kCHXAnimationConstant);
        value = startValue + variable * (endValue - startValue);
        progress += increment;
        [valuesArray addObject:@(value)];
    }
    return [NSArray arrayWithArray:valuesArray];
}

static CGPathRef CreatePathFromXYValues(NSArray* xValues, NSArray *yValues) {

    CGPoint value = CGPointMake([[xValues firstObject] doubleValue], [[yValues firstObject] doubleValue]);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, value.x, value.y);
    
    NSInteger numberOfPoints = xValues.count;
    for (NSInteger index = 0; index < numberOfPoints; index++) {
        value = CGPointMake([xValues[index] doubleValue], [yValues[index] doubleValue]);
        CGPathAddLineToPoint(path, NULL, value.x, value.y);
    }
    return path;
}

static NSArray* CreateRectArrayFrom(NSArray *xValues,
                                    NSArray *yValues,
                                    NSArray *widths,
                                    NSArray *heights) {
    
    NSInteger numberOfRects = xValues.count;
    NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:numberOfRects];
    CGRect value;
    
    for (NSInteger i = 1; i < numberOfRects; i++) {
        value = CGRectMake(
                           [[xValues objectAtIndex:i] floatValue],
                           [[yValues objectAtIndex:i] floatValue],
                           [[widths objectAtIndex:i] floatValue],
                           [[heights objectAtIndex:i] floatValue]
                           );
        [valuesArray addObject:[NSValue valueWithCGRect:value]];
    }
    return valuesArray;
}

static NSArray* CreateColorsArrayFrom(NSArray *redValues,
                                      NSArray *greenValues,
                                      NSArray *blueValues,
                                      NSArray *alphaValues) {
    
    NSInteger numberOfColors = redValues.count;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numberOfColors];
    UIColor *value;
    
    for (NSInteger index = 0; index < numberOfColors; index++) {
        value = [UIColor colorWithRed:[redValues[index] doubleValue]
                                green:[greenValues[index] doubleValue]
                                 blue:[blueValues[index] doubleValue]
                                alpha:[alphaValues[index] doubleValue]];
        [values addObject:(id)value.CGColor];
    }
    return values;
}

static NSArray* CreateTransformArrayFrom(NSArray *M11,
                                         NSArray *M12,
                                         NSArray *M13,
                                         NSArray *M14,
                                         NSArray *M21,
                                         NSArray *M22,
                                         NSArray *M23,
                                         NSArray *M24,
                                         NSArray *M31,
                                         NSArray *M32,
                                         NSArray *M33,
                                         NSArray *M34,
                                         NSArray *M41,
                                         NSArray *M42,
                                         NSArray *M43,
                                         NSArray *M44) {
    
    NSInteger numberOfTransform = M11.count;
    NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:numberOfTransform];
    
    CATransform3D value;
    for (NSInteger index = 1; index < numberOfTransform; index++) {
        value = CATransform3DIdentity;
        value.m11 = [M11[index] doubleValue];
        value.m12 = [M12[index] doubleValue];
        value.m13 = [M13[index] doubleValue];
        value.m14 = [M14[index] doubleValue];
        
        value.m21 = [M21[index] doubleValue];
        value.m22 = [M22[index] doubleValue];
        value.m23 = [M23[index] doubleValue];
        value.m24 = [M24[index] doubleValue];
        
        value.m31 = [M31[index] doubleValue];
        value.m32 = [M32[index] doubleValue];
        value.m33 = [M33[index] doubleValue];
        value.m34 = [M34[index] doubleValue];
        
        value.m41 = [M41[index] doubleValue];
        value.m42 = [M42[index] doubleValue];
        value.m43 = [M43[index] doubleValue];
        value.m44 = [M44[index] doubleValue];
        [valuesArray addObject:[NSValue valueWithCATransform3D:value]];
    }
    return valuesArray;
}

@end
