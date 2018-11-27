//
//  MHAlertViewController.m
//  MHProject
//
//  Created by 鲜恬科技 on 2018/11/24.
//  Copyright © 2018年 鲜恬科技. All rights reserved.
//

#import "MHAlertViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kContentHeight 150

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#define BtnTagBackgroundColor RGBA_COLOR(245, 245, 245, 1) //按钮高亮背景
#define LineBackgroundColor RGBA_COLOR(239, 239, 239, 1) //线条颜色

@interface MHAlertViewController ()
{
   
}

@property (nonatomic, strong, nonnull) UIButton *bkgBtn;
@property (nonatomic, strong, nonnull) UILabel * titleLab;
@property (nonatomic, strong, nonnull) UIView *customSubView; //自定义
@property (nonatomic, strong, nonnull) UILabel * subTitleLab;
@property (nonatomic, strong, nonnull) UIView *contentView;
@property (nonatomic, strong, nonnull) NSArray *btnTitleArray;
@property (nonatomic, strong, nonnull) UIView *bottomLineView;

@end


@implementation MHAlertViewController

@synthesize tagBackgroundDismissFlag = _tagBackgroundDismissFlag;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.bkgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.bkgBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
   
    [self.view addSubview:self.bkgBtn];
    
    if (self.cancelBtnTitleColor == nil ) {
        self.cancelBtnTitleColor = [UIColor redColor];
    }
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.subTitleLab];
    
    if (self.tagBackgroundDismissFlag == YES) {
        //点击背景关闭
        [self.bkgBtn addTarget:self  action:@selector(bkgBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startAnimation];
}

- (UIColor *)cancelBtnTitleColor {
    if (_cancelBtnTitleColor == nil ) {
        _cancelBtnTitleColor = [UIColor redColor];
    }
    return  _cancelBtnTitleColor;
}


/**
 内容布局

 @return :
 */
- (UIView *)contentView{
    if (_contentView == nil ) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 150, kScreenHeight/2 - 150, 300, kContentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.masksToBounds = YES;
        
        self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _contentView.frame.size.height-41, _contentView.frame.size.width, 1)];
        self.bottomLineView.backgroundColor = LineBackgroundColor;
        [_contentView addSubview:self.bottomLineView];
        
    }
    return  _contentView;
}


- (void)resetDefaultLayout{
    //取消按钮
    CGFloat btnWidth = self.contentView.frame.size.width;
    if (self.btnTitleArray.count == 1 && self.cancelBtnTitle != nil) {
        btnWidth = self.contentView.frame.size.width/(self.btnTitleArray.count + 1);
    }
    
    CGFloat cancelOrginY = 0 ;
    CGFloat cancelOrginX = 0;
    if (self.cancelBtnTitle != nil && self.btnTitleArray.count < 2) {
        //水平布局
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _contentView.frame.size.height - 40, btnWidth, 40)];
        [cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
        [cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateHighlighted];
        [cancelBtn setTitleColor:self.cancelBtnTitleColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:self.cancelBtnTitleColor forState:UIControlStateHighlighted];
        [cancelBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self createImageWithColor:BtnTagBackgroundColor] forState:UIControlStateHighlighted];
        cancelBtn.tag = 100;
        [cancelBtn addTarget:self  action:@selector(didSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:cancelBtn];
        
        cancelOrginY = CGRectGetMaxY(cancelBtn.frame);
        cancelOrginX = CGRectGetMaxX(cancelBtn.frame);
    }
    
    
    CGFloat maxHeight = kContentHeight;
    if (self.btnTitleArray.count == 1) {
        //水平布局
        for (int index = 0; index < self.btnTitleArray.count; index ++ ) {
            CGFloat orginX = index * btnWidth + cancelOrginX;  //默认左右布局
            CGFloat orginY = _contentView.frame.size.height - 40;
            
            //只有一个
            NSString *tagTitle = [self.btnTitleArray objectAtIndex:index];
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(orginX, orginY, btnWidth, 40)];
            [btn setTitle:tagTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self createImageWithColor:BtnTagBackgroundColor] forState:UIControlStateHighlighted];
            btn.tag = index;
            [btn setTitle:tagTitle forState:UIControlStateHighlighted];
            [btn addTarget:self  action:@selector(didSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:btn];
            
            if (self.btnTitleArray.count == 1) {
                UIView *lineVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, btn.frame.size.height)];
                lineVV.backgroundColor = LineBackgroundColor;
                [btn addSubview:lineVV];
            }
            maxHeight = CGRectGetMaxY(btn.frame);
        }
    }else if(self.btnTitleArray.count > 1) {
        //上下布局
        for (int index = 0; index < self.btnTitleArray.count; index ++ ) {
            CGFloat orginX = 0;  //默认左右布局
            CGFloat orginY = (_contentView.frame.size.height - 40) + 40 * index;
            
            //只有一个
            NSString *tagTitle = [self.btnTitleArray objectAtIndex:index];
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(orginX, orginY, btnWidth, 40)];
            [btn setTitle:tagTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[self createImageWithColor:BtnTagBackgroundColor] forState:UIControlStateHighlighted];
            btn.tag = index;
            [btn setTitle:tagTitle forState:UIControlStateHighlighted];
            [btn addTarget:self  action:@selector(didSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:btn];
            
            UIView *lineVV = [[UIView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height-1, btn.frame.size.width, 1)];
            lineVV.backgroundColor = LineBackgroundColor;
            [btn addSubview:lineVV];
            
            maxHeight = CGRectGetMaxY(btn.frame);
        }
        
        //最底下添加取消按钮
        if (self.cancelBtnTitle != nil) {
            //水平布局
            UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, maxHeight, btnWidth, 40)];
            [cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateNormal];
            [cancelBtn setTitle:self.cancelBtnTitle forState:UIControlStateHighlighted];
            [cancelBtn setTitleColor:self.cancelBtnTitleColor forState:UIControlStateNormal];
            [cancelBtn setTitleColor:self.cancelBtnTitleColor forState:UIControlStateHighlighted];
            [cancelBtn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [cancelBtn setBackgroundImage:[self createImageWithColor:BtnTagBackgroundColor] forState:UIControlStateHighlighted];
            cancelBtn.tag = 100;
            [cancelBtn addTarget:self  action:@selector(didSelectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:cancelBtn];
        }
        maxHeight = maxHeight + 40;
    }
    _contentView.frame = CGRectMake(_contentView.frame.origin.x , _contentView.frame.origin.y , _contentView.frame.size.width, maxHeight);

}

- (void)resetCustomLayout{
    
}


/**
 标题

 @return:
 */
- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, CGRectGetWidth(self.contentView.frame) - 80, 36)];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:20];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.numberOfLines = 0;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLab;
}


/**
 副标题

 @return :
 */
- (UILabel *)subTitleLab {
    if (_subTitleLab == nil) {
        _subTitleLab =  [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.titleLab.frame), CGRectGetWidth(self.contentView.frame) - 80, 36)];
        _subTitleLab.backgroundColor = [UIColor clearColor];
        _subTitleLab.font = [UIFont systemFontOfSize:13];
        _subTitleLab.textColor = [UIColor darkGrayColor];
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return  _subTitleLab;
}

- (UIView *)customSubView {
    if (!_customSubView) {
        _customSubView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.titleLab.frame), CGRectGetWidth(self.contentView.frame) - 40, 50)];
        _customSubView.clipsToBounds = YES;
        _customSubView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_customSubView];
    }
    return  _customSubView;
}


/**
 背景蒙层
 */
- (void)bkgBtnAction{
    [self closeAnimation];
}

- (void)startAnimation{
    self.bkgBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.26 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.bkgBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    } completion:^(BOOL finished) {
        self.bkgBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }];
}


/**
 点击按钮
 */
- (void)didSelectBtnAction:(id)sender{
    UIButton *btn = (UIButton *)sender;
    self.callBackBlock(btn.tag);
    [self closeAnimation];
}

- (void)closeAnimation{
    self.bkgBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.contentView.alpha = 1;
    [UIView animateWithDuration:0.24 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}



/**
 默认布局

 @param title 标题
 @param subTitle 副标题
 @param cancelTitle 取消按钮 为空或者为nil时不显示
 @param btnTitleArray 其它按钮 两个以上时上下排列
 @param callBack 点击事件
 */
- (void)showMHAlertViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)btnTitleArray callBack:(CallBackBlock)callBack {
    self.btnTitleArray = [[NSArray alloc] initWithArray:btnTitleArray];
    self.cancelBtnTitle = cancelTitle;
    
    self.titleLab.text = title;
    self.subTitleLab.text = subTitle;
    self.callBackBlock = callBack;
    [self resetDefaultLayout];
}


/**
 自定义subTitleView的布局
 
 @param title 标题
 @param subTitleView 自定义
 @param cancelTitle 取消按钮 为空或者为nil时不显示
 @param btnTitleArray 其它按钮 两个以上时上下排列
 @param callBack 点击事件
 */
- (void)showMHAlertCustomViewWithTitle:(NSString *)title subView:(UIView *)subTitleView cancelBtnTitle:(NSString *)cancelTitle otherBtnTitleArray:(NSArray *)btnTitleArray callBack:(CallBackBlock)callBack{
    self.btnTitleArray = [[NSArray alloc] initWithArray:btnTitleArray];
    self.cancelBtnTitle = cancelTitle;
    self.titleLab.text = title;
    [self.customSubView addSubview:subTitleView];
    self.callBackBlock = callBack;
    
    [self resetDefaultLayout];
}



/**
 颜色转图片

 @param color : 颜色
 @return :图片
 */
- (UIImage *)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
