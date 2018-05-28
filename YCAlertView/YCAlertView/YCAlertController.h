//
//  YCAlertController.h
//  YCAlertView
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 NN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YCAlertController;
/**
 alertAction配置链
 
 @param title 标题
 @return    对象
 */
typedef YCAlertController * _Nonnull (^YCAlertActionTitle)(NSString *title);

/**
 block配置

 @param alertManager 管理配置
 */
typedef void(^YCAlertManager)(YCAlertController *alertManager);
/**
 动作回调
 
 @param buttonIndex 指示标签
 @param action 弹窗动作
 @param alertController 弹窗控制器
 */
typedef void(^YCAlertActionBlock)(NSInteger buttonIndex, UIAlertAction *action, YCAlertController *alertController);
@interface YCAlertController : UIAlertController
/**
 alert弹出后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidShown)(void);

/**
 alert关闭后，可配置的回调
 */
@property (nullable, nonatomic, copy) void (^alertDidDismiss)(void);
/**
 链式构造alert视图按钮，添加一个alertAction按钮，默认样式，参数为标题
 
 @return 结果
 */
- (YCAlertActionTitle)addActionDefaultTitle;

/**
 链式构造alert视图按钮，添加一个alertAction按钮，取消样式，参数为标题(warning:一个alert该样式只能添加一次!!!)
 
 @return 返回结果
 */
- (YCAlertActionTitle)addActionCancelTitle;

/**
 链式构造alert视图按钮，添加一个alertAction按钮，警告样式，参数为标题
 
 @return 返回结果
 */
- (YCAlertActionTitle)addActionDestructiveTitle;
/**
 弹窗控制器

 @param VC 模态副控制器
 @param preferredStyle 类型
 @param title 标题
 @param message 信息
 @param manager 配置标题
 @param actionBlock 响应block
 */
- (void)nn_showAlertController:(id)VC
                preferredStyle:(UIAlertControllerStyle)preferredStyle
                         title:(NSString *)title
                       message:(nullable NSString *)message
                       manager:(YCAlertManager)manager
                   actionBlock:(YCAlertActionBlock)actionBlock;
@end
NS_ASSUME_NONNULL_END
