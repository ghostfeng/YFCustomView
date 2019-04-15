//
//  YFTextField.m
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import "YFTextField.h"

@implementation YFTextField

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
    
    [self addObserver];
}

#pragma mark - KVO
- (void)addObserver {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)removeObserver {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if (notification.object == self) {
        if (self.text.length > self.maxContentLength && self.markedTextRange == nil) {
            self.text = [self.text substringToIndex:self.maxContentLength];
        }
        if (self.textChangeHandler) {
            self.textChangeHandler(self);
        }
    }
}

- (void)dealloc {
    [self removeObserver];
}

@end
