//
//  YCAlertController.m
//  YCAlertView
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 NN. All rights reserved.
//

#import "YCAlertController.h"
#import <objc/runtime.h>

#define kColorRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
@interface YCAlertActionModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) UIAlertActionStyle style;
@end
@implementation YCAlertActionModel
- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"";
        self.style = UIAlertActionStyleDefault;
    }
    return self;
}
@end

@interface YCAlertAction : UIAlertAction
//@property (nonatomic, strong) <#type#> *<#name#>;
@end

@implementation YCAlertAction

@end

/**
 AlertActions配置
 
 @param actionBlock JXTAlertActionBlock
 */
typedef void (^YCAlertActionsConfig)(YCAlertActionBlock actionBlock);

@interface YCAlertController ()
/**
 标题
 */
@property (nonatomic, strong) NSString *alertTitle;
/**
 信息
 */
@property (nonatomic, strong) NSString *alertMessage;
//YCAlertActionModel数组
@property (nonatomic, strong) NSMutableArray <YCAlertActionModel *>* alertActionArray;
//action配置
- (YCAlertActionsConfig)alertActionsConfig;
@end

@implementation YCAlertController
#pragma mark - Lifecycle
- (instancetype)initAlertControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
{
    if (!(title.length > 0) && (message.length > 0) && (preferredStyle == UIAlertControllerStyleAlert)) {
        title = @"";
    }
    self = [[self class] alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (self){
        _alertTitle = title;
        _alertMessage = message;
        [self _configAlertUI];
    };
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessor
- (NSMutableArray<YCAlertActionModel *> *)alertActionArray{
    if (_alertActionArray == nil) {
        _alertActionArray = [[NSMutableArray alloc] init];
    }
    return _alertActionArray;
}
#pragma mark ------------------- Privacy ----------------------
/**
 修改UI
 */
- (void)_configAlertUI
{
    if (_alertTitle && _alertTitle.length > 0) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:_alertTitle];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:kColorRGB(0X030303) range:NSMakeRange(0, _alertTitle.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, _alertTitle.length)];
        [self setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    //修改message
    if (_alertMessage && _alertMessage.length > 0) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:_alertMessage];
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:kColorRGB(0X030303) range:NSMakeRange(0, _alertMessage.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, _alertMessage.length)];
        [self setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
//    for (int i = 0; i < count; i++) {
//        Ivar ivar = *(ivars+i);
//        Ivar ivar = ivars[i];
//        // 打印成员变量名字
//        NSLog(@"%s------%s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
//    }
}
#pragma mark ------------------- Public ----------------------
- (YCAlertActionTitle)addActionDefaultTitle
{
    return ^(NSString *title) {
        YCAlertActionModel *model = [[YCAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDefault;
        [self.alertActionArray addObject:model];
        return self;
    };
}

- (YCAlertActionTitle)addActionCancelTitle
{
    return ^(NSString *title) {
        YCAlertActionModel *model = [[YCAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleCancel;
        [self.alertActionArray addObject:model];
        return self;
    };
}

- (YCAlertActionTitle)addActionDestructiveTitle
{
    return ^(NSString *title) {
        YCAlertActionModel *model = [[YCAlertActionModel alloc] init];
        model.title = title;
        model.style = UIAlertActionStyleDestructive;
        [self.alertActionArray addObject:model];
        return self;
    };
}

- (YCAlertActionsConfig)alertActionsConfig{
    return ^(YCAlertActionBlock actionBlock){
        if (self.alertActionArray.count > 0) {
            //创建响应按键
            __weak typeof(self)weakSelf = self;
            [self.alertActionArray enumerateObjectsUsingBlock:^(YCAlertActionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj.title style:obj.style handler:^(UIAlertAction * _Nonnull action) {
                    __strong typeof(weakSelf)strongSelf = weakSelf;
                    if (actionBlock) {
                        actionBlock(idx, action, strongSelf);
                    }
                }];
                if (obj.style == UIAlertActionStyleCancel) {
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.3f) {
                        [alertAction setValue:kColorRGB(0x69BF30) forKey:@"_titleTextColor"];
                    }
                    else
                    {
                        self.view.tintColor = kColorRGB(0x69BF30);
                    }
                    
                }
                else
                {
                    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.3f) {
                        [alertAction setValue:kColorRGB(0x69BF30) forKey:@"_titleTextColor"];
                    }
                    else
                    {
                        self.view.tintColor = kColorRGB(0x69BF30);
                    }
                }
                
                [self addAction:alertAction];
            }];
        }
    };
}

- (void)nn_showAlertController:(id)VC
                preferredStyle:(UIAlertControllerStyle)preferredStyle
                         title:(NSString *)title
                       message:(nullable NSString *)message
                       manager:(YCAlertManager)manager
                   actionBlock:(YCAlertActionBlock)actionBlock
{
    if (manager) {
        YCAlertController *alertManager = [self initAlertControllerWithTitle:title message:message preferredStyle:preferredStyle];
        if (!alertManager) {
            return;
        }
        
        manager(alertManager);
        //配置
        alertManager.alertActionsConfig(actionBlock);
        
        if (alertManager.alertDidShown) {
            if ([VC isKindOfClass:[UIViewController class]]) {
                [VC presentViewController:alertManager animated:YES completion:^{
                    alertManager.alertDidShown();
                }];
            }
        }
        else
        {
            if ([VC isKindOfClass:[UIViewController class]]) {
                [VC presentViewController:alertManager animated:YES completion:nil];
            }
        }
    }
}
@end
