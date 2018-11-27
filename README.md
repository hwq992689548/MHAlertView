# MHAlertView
仿IOS自定义AlertView,标题 副标题 按钮界面可以自己定义

![Image1][https://github.com/hwq992689548/MHAlertView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-11-27%20at%2011.19.24.png?raw=true

]
![Image2][https://github.com/hwq992689548/MHAlertView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-11-27%20at%2011.19.38.png?raw=true
]
![Image3][https://github.com/hwq992689548/MHAlertView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-11-27%20at%2011.21.28.png?raw=true]
![Image3][https://github.com/hwq992689548/MHAlertView/blob/master/Simulator%20Screen%20Shot%20-%20iPhone%20XR%20-%202018-11-27%20at%2011.21.18.png?raw=true]




    //默认Alert
      [[MHAlertView sharedInstance] showMHAlertInView:self.view title:@"标题" subTitle:@"副标题" cancelBtnTitle:@"取消" otherBtnTitleArray:@[@"确定"] callBack:^(NSInteger tag) {
          NSLog(@"%ld", tag);
      }];
    
    
      //自定义alertView
      UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 360)];
      vv.backgroundColor = [UIColor greenColor];
      [MHAlertView sharedInstance] showCustomAlertInView:self.view title:@"副标题" subView:vv cancelBtnTitle:@"取消" otherBtnTitleArray:@[@"确定"] callBack:^(NSInteger tag) {
          NSLog(@"%ld", tag);
      }
