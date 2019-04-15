//
//  YFCountDownButton.h
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

/**
 * 倒计时按钮
 */

#import <UIKit/UIKit.h>

@interface YFCountDownButton : UIButton

/** 倒计时总时间 */
@property (assign, nonatomic) NSTimeInterval durationTotal;
/** 时间前面的提示 */
@property (nonatomic, copy) NSString *timePrefix;
/** 时间后面的提示 */
@property (nonatomic, copy) NSString *timeSuffix;
/** 正常的按钮 */
@property (nonatomic, copy) NSString *normalTitle;

/**
 开始倒计时
 */
- (void)startCountDown;

@end
