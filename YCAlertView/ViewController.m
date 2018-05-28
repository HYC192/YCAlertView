//
//  ViewController.m
//  YCAlertView
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 NN. All rights reserved.
//

#import "ViewController.h"
#import "YCAlertView.h"
#import "YCAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAction:(id)sender {
    [YCAlertView showAlertViewWithTitle:@"测试" message:@"我是在调试弹窗1，修改样式" cancelButtonTitle:@"取消" buttonIndexBlock:^(NSInteger index) {
        NSLog(@"....%ld", index);
        switch (index) {
            case 0:
            {
                
            }
                break;
                
            case 1:
            {
                
            }
                break;
                
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    } otherButtonTitles:@"确定", @"其它", nil];
    return;
    YCAlertController *alertVC = [YCAlertController new];
    [alertVC nn_showAlertController:self
                     preferredStyle:UIAlertControllerStyleAlert
                              title:@"测试"
                            message:@"弹窗控制器"
                            manager:^(YCAlertController * _Nonnull alertManager) {
                                alertManager.addActionCancelTitle(@"取消").addActionDefaultTitle(@"确定");
                            }
                        actionBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, YCAlertController * _Nonnull alertController) {
                            if (buttonIndex == 0) {
                                NSLog(@"cancel");
                            }
                            else if (buttonIndex == 1) {
                                NSLog(@"按钮1");
                            }
                            NSLog(@"%@--%@", action.title, action);
                        }];
    
    return;
    YCAlertController *alert = [YCAlertController alertControllerWithTitle:@"233" message:@"12132123" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:defult];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
    
    return;
    YCAlertView *alertView = [[YCAlertView alloc] initWithTitle:@"测试" message:@"我是在调试弹窗1，修改样式" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    YCAlertView *alertView1 = [[YCAlertView alloc] initWithTitle:@"测试" message:@"我是在调试弹窗2，修改样式" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView1 show];
}

@end
