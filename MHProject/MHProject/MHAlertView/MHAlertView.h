//
//  MHAlertView.h
//  MHProject
//
//  Created by 鲜恬科技 on 2018/11/27.
//  Copyright © 2018 鲜恬科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHAlertViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBackBlock) (NSInteger tag); //1

@interface MHAlertView : UIView
@property (nonatomic,copy)CallBackBlock callBackBlock; //2

+ (instancetype)sharedInstance;
- (void)showMHAlertInView:(UIView *)parantView title:(NSString *)title subTitle:(NSString *)subTitle cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)array callBack:(CallBackBlock)callBack;

- (void)showMHAlertInView:(UIView *)parantView title:(NSString *)title subView:(UIView *)subView cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)array callBack:(CallBackBlock)callBack;

@end

NS_ASSUME_NONNULL_END
