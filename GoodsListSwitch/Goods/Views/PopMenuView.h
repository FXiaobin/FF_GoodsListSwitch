//
//  PopMenuView.h
//  dfds
//
//  Created by fanxiaobin on 17/3/8.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^menuViewClick)(NSString *title, NSInteger index);

@interface PopMenuView : UIView

@property (nonatomic,copy) menuViewClick menuViewClickBlock;

-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

- (void)showPopMenuView;

@end
