//
//  YFPageControl.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "YFPageControl.h"

@interface YFPageControl ()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

@end

@implementation YFPageControl

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    [super setNumberOfPages:numberOfPages];
    
    [self.imageViews removeAllObjects];
    
    for (UIView *subView in self.subviews) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.pageIndicatorImage highlightedImage:self.currentPageIndicatorImage];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.clipsToBounds = true;
        for (UIView *view in subView.subviews) {
            [view removeFromSuperview];
        }
        [subView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage {
    _pageIndicatorImage = pageIndicatorImage;
    
    for (UIImageView *imageView in self.imageViews) {
        imageView.image = pageIndicatorImage;
    }
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage {
    _currentPageIndicatorImage = currentPageIndicatorImage;
    
    for (UIImageView *imageView in self.imageViews) {
        imageView.highlightedImage = currentPageIndicatorImage;
    }
}

- (NSMutableArray<UIImageView *> *)imageViews {
    if (!_imageViews) {
        _imageViews = [[NSMutableArray<UIImageView *> alloc]init];
    }
    return _imageViews;
}

- (void)setupSubviews {
    self.userInteractionEnabled = false;
    self.hidesForSinglePage = true;
    self.backgroundColor = [UIColor clearColor];
    
    [self setDefaultConfig];
}


/**
 设置默认配置
 */
- (void)setDefaultConfig {
    self.pageIndicatorRadius = 3.5;
    self.pageIndicatorMargin = 7;
    self.pageIndicatorSize = CGSizeMake(7, 7);
    self.currentPageIndicatorSize = CGSizeMake(7, 7);
    self.userInteractionEnabled = false;
}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = [self.subviews count];
    
    CGFloat pageIndicatorX = (self.frame.size.width - (count - 1) * (self.pageIndicatorMargin + self.pageIndicatorSize.width) - self.currentPageIndicatorSize.width) * 0.5;
    if (pageIndicatorX < 0) {
        pageIndicatorX = 0;
    }
    CGFloat pageIndicatorY = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIView* subview = [self.subviews objectAtIndex:i];
        UIImageView *imageView = subview.subviews.firstObject;
        if (imageView == nil) {
            imageView = self.imageViews[i];
            [subview addSubview:imageView];
        }
        
        if (i == self.currentPage) {
            pageIndicatorY = (self.frame.size.height - self.currentPageIndicatorSize.height) * 0.5;
            //当前选中的点
            [subview setFrame:CGRectMake(pageIndicatorX, pageIndicatorY, self.currentPageIndicatorSize.width, self.currentPageIndicatorSize.height)];
            imageView.highlighted = true;
        } else {
            pageIndicatorY = (self.frame.size.height - self.pageIndicatorSize.height) * 0.5;
            [subview setFrame:CGRectMake(pageIndicatorX, pageIndicatorY, self.pageIndicatorSize.width, self.pageIndicatorSize.height)];
            imageView.highlighted = false;
        }
        
        imageView.frame = subview.bounds;
        //设置裁剪半径
        subview.layer.masksToBounds = true;
        subview.layer.cornerRadius = self.pageIndicatorRadius;
        //累加x坐标
        pageIndicatorX += (CGRectGetWidth(subview.frame) + self.pageIndicatorMargin);
    }
}


@end
