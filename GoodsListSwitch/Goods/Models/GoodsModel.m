//
//  GoodsModel.m
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

+ (GoodsModel *)makeModelWithDic:(NSDictionary *)dic{
    GoodsModel *model = [[GoodsModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.goodId = value;
    }
}


@end
