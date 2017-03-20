//
//  BannerReusableView.m
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "BannerReusableView.h"

@interface BannerReusableView ()

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@end

@implementation BannerReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 80 - 20;
        self.cycleScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(10, 5, width, 116 / 276.0 * width)];
        self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"5financial_default"];
        self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        self.cycleScrollView.pageDotColor = [UIColor orangeColor];
        
        self.cycleScrollView.clipsToBounds = YES;
        self.cycleScrollView.layer.cornerRadius = 6.0;
        
        [self addSubview:self.cycleScrollView];
    }
    return self;
}


-(void)setBannerArr:(NSArray *)bannerArr{
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    for (NSDictionary *dic in bannerArr) {
        NSString *urlString = dic[@"picture_url"] ? dic[@"picture_url"] : @"";
        [imageURLs addObject:urlString];
    }
    self.cycleScrollView.imageURLStringsGroup = imageURLs;
}

@end
