//
//  CollectionReusableHeaderView.h
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^moreBtnAction) (UIButton *sender);

@interface CollectionReusableHeaderView : UICollectionReusableView


@property (nonatomic,copy) moreBtnAction moreBtnActionBlock;

@end
