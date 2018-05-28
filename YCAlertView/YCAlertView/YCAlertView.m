//
//  YCAlertView.m
//  YCAlertView
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 NN. All rights reserved.
//

#import "YCAlertView.h"
#import <objc/runtime.h>

@interface YCAlertView ()<UIAlertViewDelegate>
@property (nonatomic, copy) alertActionBlock buttonClickBlock;
@property (nonatomic, copy) alertActionBlock completionBlock;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION;
@end
@implementation YCAlertView
#pragma mark - Lifecycle
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ...
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    if (self) {
        
    }
    return self;
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
    unsigned int count;
    Ivar *ivars =  class_copyIvarList([UIAlertView class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"%s =============== %s",name,type);
    }
    free(ivars);
}

#pragma mark ------------------- Public ----------------------
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle buttonIndexBlock:(alertActionBlock)buttonIndexBlock otherButtonTitles:(NSString *)otherButtonTitles, ...{
    if (!(title.length > 0) && message.length > 0) {
        title = @"";
    }
    
    YCAlertView *alertView = [[YCAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitle:nil];
    alertView.buttonClickBlock = buttonIndexBlock;
    if (otherButtonTitles)
    {
        va_list args;//定义一个指向个数可变的参数列表指针
        va_start(args, otherButtonTitles);//得到第一个可变参数地址
        for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString *))
        {
            [alertView addButtonWithTitle:arg];
        }
        va_end(args);//置空指针
    }
    
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(buttonIndex);
    }
    self.buttonClickBlock = NULL;//解除闭环
}

@end
