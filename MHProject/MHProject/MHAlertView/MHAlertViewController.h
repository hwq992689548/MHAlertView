//
//  MHAlertViewController.h
//  MHProject
//
//  Created by 鲜恬科技 on 2018/11/24.
//  Copyright © 2018年 鲜恬科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CallBackBlock) (NSInteger tag); //1


@interface MHAlertViewController : UIViewController
@property (nonatomic) BOOL tagBackgroundDismissFlag;

@property (nonatomic,copy)CallBackBlock callBackBlock; //2

@property (nonatomic, copy, nullable) NSString * cancelBtnTitle;     //默认： 取消
@property (nonatomic, copy, nullable) UIColor * cancelBtnTitleColor;  //默认redColor
@property (nonatomic, copy, nullable) UIFont * cancelBtnTitleFont;  //默认redColor



/**
 默认布局
 
 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮 为空或者为nil时不显示
 @param btnTitleArray 其它按钮 两个以上时上下排列
 @param callBack 点击事件
 */
- (void)showMHAlertViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)btnTitleArray callBack:(CallBackBlock)callBack;


/**
 自定义subTitleView的布局
 
 @param title 标题
 @param subView 自定义
 @param cancelTitle 取消按钮 为空或者为nil时不显示
 @param btnTitleArray 其它按钮 两个以上时上下排列
 @param callBack 点击事件
 */
- (void)showMHAlertCustomViewWithTitle:(NSString *)title subView:(UIView *)subTitleView cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)btnTitleArray callBack:(CallBackBlock)callBack;

@end


NS_ASSUME_NONNULL_END
