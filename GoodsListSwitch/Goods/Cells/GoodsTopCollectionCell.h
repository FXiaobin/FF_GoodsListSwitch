//
//  GoodsTopCollectionCell.h
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTopCollectionCell : UICollectionViewCell

@property (nonatomic,copy) void (^imageTapActionBlock) (NSInteger tag);
-(void)makeCellWithRecommondArray:(NSArray *)recommondArr;

@end
