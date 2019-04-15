//
//  YFTextView.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "YFTextView.h"

@implementation YFTextView

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
    //默认字数不限制
    self.maxContentLength = NSIntegerMax;
    self.textContainerInset = UIEdgeInsetsMake(2, 0, 2, 0);
    
    [self addObserver];
}

#pragma mark - KVO
- (void)addObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)removeObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

- (void)textViewTextDidChange:(NSNotification *)notification {
    if (notification.object == self) {
        if (self.text.length > self.maxContentLength && self.markedTextRange == nil) {
            self.text = [self.text substringToIndex:self.maxContentLength];
        }
        if (self.textChangeHandler) {
            self.textChangeHandler(self);
        }
    }
}

- (CGFloat)contentHeight {
    return [self sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].height;
}

- (void)dealloc {
    [self removeObserver];
}

@end
