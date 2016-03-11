//
//  CHXKeyframeAnimation.h
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSBKeyframeAnimationFunctions.h"

typedef double(^NSBKeyframeAnimationFunctionBlock)(double t, double b, double c, double d);

@interface CHXKeyframeAnimation : CAKeyframeAnimation

@property (copy, nonatomic) NSBKeyframeAnimationFunctionBlock functionBlock;

@property (strong, nonatomic) id fromValue;
@property (strong, nonatomic) id toValue;

- (void)calculate;

@end
