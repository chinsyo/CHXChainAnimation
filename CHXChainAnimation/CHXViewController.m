//
//  CHXViewController.m
//  CHXChainAnimation
//
//  Created by 王晨晓 on 16/3/11.
//  Copyright © 2016年 winsan. All rights reserved.
//

#import "CHXViewController.h"
#import "CHXChainAnimation.h"
#import "UIView+CHXChainAnimationPrivate.h"

@interface CHXViewController ()

@property (strong, nonatomic) UIView *myView;

@end

@implementation CHXViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myView = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 50, 50)];
    self.myView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.myView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.bounds.size.height-50.0, self.view.bounds.size.width, 50.0);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"Action!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(animateView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)animateView:(UIButton *)sender {
    
    sender.userInteractionEnabled = NO;
    
    __weak CHXViewController *weakSelf = self;
    
    self.myView.animationCompletion = CHXAnimationCompletion() {

        weakSelf.myView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        weakSelf.myView.frame = CGRectMake(100, 150, 50, 50);
        weakSelf.myView.makeOpacity(1.0).makeBackground([UIColor blueColor]).animate(1.0);
        
        sender.moveY(-50).easeInOutExpo.animate(1.1).animationCompletion = CHXAnimationCompletion() {
            sender.userInteractionEnabled = YES;
        };
    };
    
    UIColor *purple = [UIColor purpleColor];
    self.myView.moveWidth(50).bounce.makeBackground(purple).easeIn.anchorTopLeft.
    thenAfter(0.8).rotate(95).easeBack.wait(0.2).
    thenAfter(0.5).moveY(300).easeIn.makeOpacity(0.0).animate(0.4);

    sender.moveY(50).easeInOutExpo.animate(0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
