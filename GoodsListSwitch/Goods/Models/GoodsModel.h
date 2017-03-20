//
//  GoodsModel.h
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,strong) NSNumber *goodId;
@property (nonatomic,strong) NSNumber *catId;
@property (nonatomic,strong) NSString *catName;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThumb;
@property (nonatomic,strong) NSNumber *marketPrice;
@property (nonatomic,strong) NSNumber *shopDiamonds;

+(GoodsModel *)makeModelWithDic:(NSDictionary *)dic;

@end
