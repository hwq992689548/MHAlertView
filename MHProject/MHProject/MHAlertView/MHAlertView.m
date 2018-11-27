//
//  MHAlertView.m
//  MHProject
//
//  Created by 鲜恬科技 on 2018/11/27.
//  Copyright © 2018 鲜恬科技. All rights reserved.
//

#import "MHAlertView.h"

@implementation MHAlertView

+ (id)sharedInstance {
    static MHAlertView *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)showMHAlertInView:(UIView *)parantView title:(NSString *)title subTitle:(NSString *)subTitle cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)array callBack:(CallBackBlock)callBack {
    self.callBackBlock = callBack;
    
    MHAlertViewController *vc = [[MHAlertViewController alloc] init];
    [vc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    //默认alert
    [vc showMHAlertViewWithTitle:@"我是标题title" subTitle:@"我是副标题subTitle我是副标题subTitle我是副标题subTitle" cancelBtnTitle: @"取消" otherBtnTitleArray:@[@"确定1",@"确定2"] callBack:^(NSInteger tag) {
        NSLog(@"%ld", tag); //100为取消按钮
    }];
    
    
    //自定义alertView
//    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 360)];
//    vv.backgroundColor = [UIColor greenColor];
//    [vc showMHAlertCustomViewWithTitle:@"我是标题title" subView:vv cancelBtnTitle:@"取消" otherBtnTitleArray:@[@"确定"] callBack:^(NSInteger tag) {
//        NSLog(@"%ld", tag); //100为取消按钮
//    }];
    
    
    
    [parantView addSubview:self];
    [[self viewController] presentViewController:vc  animated:NO completion:nil];
}


- (UIViewController *)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
        
    }
    
    return nil;
    
}
@end
