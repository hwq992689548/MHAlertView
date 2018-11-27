//
//  ViewController.m
//  MHProject
//
//  Created by 鲜恬科技 on 2018/11/24.
//  Copyright © 2018年 鲜恬科技. All rights reserved.
//

#import "ViewController.h"
#import "MHAlertView/MHAlertViewController.h"
#import "MHAlertView/MHAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self  action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction{
    
    
    [[MHAlertView sharedInstance] showMHAlertInView:self.view title:@"标题" subTitle:@"副标题" cancelBtnTitle:@"取消" otherBtnTitleArray:@[@"确定"] callBack:^(NSInteger tag) {
        NSLog(@"%ld", tag);
    }];
    
//    MHAlertViewController *vc = [[MHAlertViewController alloc] init];
//
//    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//    [vc showMHAlertViewWithTitle:@"我是标题title" subTitle:@"我是副标题subTitle我是副标题subTitle我是副标题subTitle" cancelBtnTitle: @"取消" otherBtnTitleArray:@[@"确定1",@"确定2"] callBack:^(NSInteger tag) {
//        NSLog(@"%ld", tag); //100为取消按钮
//    }];

    
//    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 360)];
//    vv.backgroundColor = [UIColor greenColor];
//
//    [vc showMHAlertCustomViewWithTitle:@"自定义subView标题" subView:vv  cancelBtnTitle:@"取消" otherBtnTitleArray:@[@"确定"] callBack:^(NSInteger tag) {
//
//    }];
//    [self presentViewController:vc  animated:NO completion:nil];
    
  
}



@end
