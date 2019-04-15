//
//  YFMarqueeView.h
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

/**
 * 跑马灯
 */

#import <UIKit/UIKit.h>

/**
 * 跑马灯类型
 */
typedef NS_ENUM(NSInteger, YFMarqueeType) {
    /** 向左 */
    YFMarqueeTypeLeft = 0,
    /** 向右 */
    YFMarqueeTypeRight = 1,
    /** 左右循环往复 */
    YFMarqueeTypeReverse = 2
};

@interface YFMarqueeView : UIView

/** 两个视图之间的间隔(默认20) */
@property (nonatomic, assign) CGFloat contentMargin;
/** 类型(默认向左) */
@property (nonatomic, assign) YFMarqueeType type;
/** 多少帧回调一次（默认1），一帧时间 1/60秒 */
@property (nonatomic, assign) NSInteger frameInterval;
/** 每帧移动多少个点(默认0.5) */
@property (nonatomic, assign) CGFloat pointsPerFrame;

/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;

/**
 刷新
 */
- (void)reloadData;

@end
