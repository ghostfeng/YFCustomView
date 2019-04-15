//
//  ViewController.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "ViewController.h"

#import "YFMarqueeView.h"
#import "YFCountDownButton.h"
#import "YFPageControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //跑马灯
    YFMarqueeView *marquee = [[YFMarqueeView alloc] initWithFrame:CGRectMake(10, 60, 300, 60)];
    marquee.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！清仓大甩卖！";
    marquee.contentView = label;
    [self.view addSubview:marquee];
    
    //倒计时
    YFCountDownButton *button = [[YFCountDownButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(marquee.frame), 100, 40)];
    button.backgroundColor = [UIColor lightGrayColor];
    button.timePrefix = @"";
    button.timeSuffix = @"秒后重试";
    button.normalTitle = @"获取验证码";
    button.durationTotal = 60;
    [button addTarget:self action:@selector(countDownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //分页指示器
    YFPageControl *pageCtrl = [[YFPageControl alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(button.frame), 300, 30)];
    pageCtrl.numberOfPages = 4;
    pageCtrl.userInteractionEnabled = true;
    pageCtrl.pageIndicatorRadius = 7.5;
    pageCtrl.currentPageIndicatorSize = CGSizeMake(30, 15);
    pageCtrl.pageIndicatorSize = CGSizeMake(15, 15);
    pageCtrl.currentPageIndicatorTintColor = [UIColor redColor];
    pageCtrl.pageIndicatorTintColor = [UIColor greenColor];
    [self.view addSubview:pageCtrl];
}

- (void)countDownAction:(YFCountDownButton *)button {
    [button startCountDown];
}


@end
