//
//  YFTextField.h
//  YFCustomViewDemo
//
//  Created by 刘永峰 on 2019/4/15.
//  Copyright © 2019 刘永峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFTextField : UITextField

/** 最大的输入文本数 */
@property (nonatomic, assign) IBInspectable NSUInteger maxContentLength;
/** 文本改变回调 */
@property (nonatomic, copy) void(^textChangeHandler)(YFTextField *textField);

@end
