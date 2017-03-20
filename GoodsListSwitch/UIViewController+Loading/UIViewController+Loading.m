//
//  UIViewController+Loading.m
//  dfds
//
//  Created by liwei on 17/3/10.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "UIViewController+Loading.h"


#define SHOWLOADINGVIEW_TAG 903456950349

@implementation UIViewController (Loading)

- (void)showLoading{
    
    UIView *loadingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    loadingView.backgroundColor = [UIColor whiteColor];
    loadingView.tag = SHOWLOADINGVIEW_TAG;
    [self.view addSubview:loadingView];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.center = loadingView.center;
    [indicatorView startAnimating];
    [loadingView addSubview:indicatorView];
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2.0, CGRectGetMaxY(indicatorView.frame) + 20, 200, 20)];
    tipLabel.text = @"奋力加载中...";
    tipLabel.textAlignment = NSTextAlignmentCenter;

    [loadingView addSubview:tipLabel];
    
    
}

- (void)hiddenLoading{
    
    for (UIView *subView in self.view.subviews) {
        if (subView.tag == SHOWLOADINGVIEW_TAG) {
            UIView *loadingView = subView;
            if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
                UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)subView;
                [indicatorView stopAnimating];
            }
            [subView removeFromSuperview];
            [loadingView removeFromSuperview];
        }
        
    }
}

@end
