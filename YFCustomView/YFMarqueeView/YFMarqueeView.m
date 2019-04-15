//
//  YFMarqueeView.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "YFMarqueeView.h"

@interface YFMarqueeView ()

/** 内容容器 */
@property (nonatomic, strong) UIView *containerView;
/** 定时器 */
@property (nonatomic, strong) CADisplayLink *displayLink;
/** 是否循环到头(默认否) */
@property (nonatomic, assign) BOOL isReversing;

@end

@implementation YFMarqueeView

- (instancetype)init {
    if (self = [self initWithFrame:CGRectZero]) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.contentMargin = 20;
    self.type = YFMarqueeTypeLeft;
    self.frameInterval = 1;
    self.pointsPerFrame = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = true;
    [self addSubview:self.containerView];
}

#pragma mark - getter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

#pragma mark - setter
- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    
    [self setNeedsLayout];
}

#pragma mark - 定时器

/**
 开启定时器
 */
- (void)startDisplayLink {
    [self stopDisplayLink];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    self.displayLink.frameInterval = self.frameInterval;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

/**
 停止定时器
 */
- (void)stopDisplayLink {
    if (self.displayLink) {
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
}

/**
 定时器action
 */
- (void)displayLinkAction {
    CGRect frame = self.containerView.frame;
    
    if (self.contentView.frame.size.width <= self.frame.size.width) return;
    
    switch (self.type) {
        case YFMarqueeTypeLeft: {
            //向左
            CGFloat minOrginX = -(self.contentView.frame.size.width + self.contentMargin);
            if (frame.origin.x <= minOrginX) {
                frame.origin.x = 0;
            } else {
                frame.origin.x -= self.pointsPerFrame;
            }
            self.containerView.frame = frame;
        }
            break;
        case YFMarqueeTypeRight: {
            //向右
            CGFloat maxOrginX = self.frame.size.width - self.contentView.frame.size.width;
            if (frame.origin.x >= maxOrginX) {
                frame.origin.x = self.frame.size.width - self.containerView.frame.size.width;
            } else {
                frame.origin.x += self.pointsPerFrame;
            }
            self.containerView.frame = frame;
        }
            break;
        case YFMarqueeTypeReverse: {
            //左右循环往复
            if (self.isReversing) {
                CGFloat maxOrginX = 0;
                if (frame.origin.x >= maxOrginX) {
                    frame.origin.x = maxOrginX;
                    self.isReversing = false;
                } else {
                    frame.origin.x += self.pointsPerFrame;
                }
            } else {
                CGFloat minOrginX = self.frame.size.width - self.contentView.frame.size.width;
                if (frame.origin.x <= minOrginX) {
                    frame.origin.x = minOrginX;
                    self.isReversing = true;
                } else {
                    frame.origin.x -= self.pointsPerFrame;
                }
            }
            self.containerView.frame = frame;
        }
            break;
    }
}

/**
 刷新
 */
- (void)reloadData {
    [self setNeedsLayout];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview == nil) {
        [self stopDisplayLink];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.contentView == nil) {
        return;
    }
    
    for (UIView *subView in self.containerView.subviews) {
        [subView removeFromSuperview];
    }
    
    [self.contentView sizeToFit];
    self.contentView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height);
    [self.containerView addSubview:self.contentView];
    
    switch (self.type) {
        case YFMarqueeTypeLeft: {
            //向左
            self.containerView.frame = CGRectMake(0, 0, self.contentView.frame.size.width * 2 + self.contentMargin, self.frame.size.height);
        }
            break;
        case YFMarqueeTypeRight: {
            //向右
            self.containerView.frame = CGRectMake(self.frame.size.width - (self.contentView.frame.size.width * 2 + self.contentMargin), 0, self.contentView.frame.size.width * 2 + self.contentMargin, self.frame.size.height);
        }
            break;
        case YFMarqueeTypeReverse: {
            //左右循环往复
            self.containerView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.frame.size.height);
        }
            break;
    }
    
    //内容超过可显示区
    if (self.contentView.frame.size.width > self.frame.size.width) {
        if (self.type != YFMarqueeTypeReverse) {
            //拷贝一份
            NSData *copyContentViewData = [NSKeyedArchiver archivedDataWithRootObject:self.contentView];
            UIView *copyContentView = [NSKeyedUnarchiver unarchiveObjectWithData:copyContentViewData];
            copyContentView.frame = CGRectMake(self.contentView.frame.size.width + self.contentMargin, 0, self.contentView.frame.size.width, self.frame.size.height);
            [self.containerView addSubview:copyContentView];
        }
    }
    
    //开启定时器
    [self startDisplayLink];
}

@end
