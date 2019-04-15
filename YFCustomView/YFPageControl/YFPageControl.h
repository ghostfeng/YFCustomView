//
//  YFPageControl.h
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

/**
 * 自定义UIPageControl
 */

#import <UIKit/UIKit.h>

@interface YFPageControl : UIPageControl

/** 指示器裁剪半径 */
@property (nonatomic, assign) CGFloat pageIndicatorRadius; //Default is 3.5
/** 指示器间距 */
@property (nonatomic, assign) CGFloat pageIndicatorMargin;//Default is 7
/** 指示器大小 */
@property (nonatomic) CGSize pageIndicatorSize;//Default is 7 x 7
/** 当前页码指示器大小 */
@property (nonatomic) CGSize currentPageIndicatorSize;//Default is 7 x 7
/** 指示器图片 */
@property (nonatomic, strong) UIImage *pageIndicatorImage;//Default is nil
/** 当前页码指示器图片 */
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;//Default is nil

@end
