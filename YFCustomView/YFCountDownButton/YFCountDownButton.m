//
//  YFCountDownButton.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "YFCountDownButton.h"

@interface YFCountDownButton ()

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
/** 当前倒计时时间 */
@property (assign, nonatomic) NSTimeInterval currentDuration;

@end

@implementation YFCountDownButton

#pragma mark - getter/setter
- (void)setNormalTitle:(NSString *)normalTitle {
    _normalTitle = normalTitle;
    
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:normalTitle forState:UIControlStateDisabled];
}

- (void)setDurationTotal:(NSTimeInterval)durationTotal {
    _durationTotal = durationTotal;
    self.currentDuration = durationTotal;
}

- (void)dealloc {
    [self invalidateTimer];
}

- (void)timeChange:(NSTimer *)timer {
    self.currentDuration--;
    if (self.currentDuration > 0) {
        [self setTitle:[self disableTitleWithDuration:self.currentDuration] forState:UIControlStateDisabled];
    } else {
        self.enabled = true;
        [self setTitle:self.normalTitle forState:UIControlStateDisabled];
        self.currentDuration = self.durationTotal;
        [self invalidateTimer];
    }
}

- (void)invalidateTimer{
    if (!self.isEnabled) {
        self.enabled = YES;
    }
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)startCountDown {
    if (self.isEnabled) {
        self.enabled = false;
    }
    
    [self setTitle:[self disableTitleWithDuration:self.durationTotal] forState:UIControlStateDisabled];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timeChange:)
                                                userInfo:nil
                                                 repeats:YES];
}


/**
 不可点的按钮标题
 
 @param duration 时间
 @return return value description
 */
- (NSString *)disableTitleWithDuration:(NSTimeInterval)duration {
    NSString *timePrefix = (self.timePrefix.length > 0) ? self.timePrefix : @"";
    NSString *timeSuffix = (self.timeSuffix.length > 0) ? self.timeSuffix : @"";
    return [NSString stringWithFormat:@"%@%.0f%@",timePrefix, duration, timeSuffix];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self invalidateTimer];
    }
}

@end
