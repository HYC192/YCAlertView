//
//  YCAlertView.h
//  YCAlertView
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 NN. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 动作回调

 @param index 指示标签
 */
typedef void(^alertActionBlock)(NSInteger index);

@interface YCAlertView : UIAlertView
/**
 弹窗设置

 @param title 标题
 @param message 信息
 @param cancelButtonTitle 取消按键
 @param buttonIndexBlock 动作响应
 @param otherButtonTitles 其它按键
 */
+ (void)showAlertViewWithTitle:(nullable NSString *)title
                       message:(nullable NSString *)message
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
              buttonIndexBlock:(nullable alertActionBlock)buttonIndexBlock
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end
