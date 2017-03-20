//
//  SDCycleBannerView.m
//  dfds
//
//  Created by fanxiaobin on 17/3/13.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "SDCycleBannerView.h"

@interface SDCycleBannerView ()<SDCycleScrollViewDelegate>

@property (nonatomic,copy) imageViewTap imageViewTapBlock;

@end

@implementation SDCycleBannerView

-(instancetype)initWithFrame:(CGRect)frame placeholderImage:(NSString *)placeholderImage imageViewTap:(imageViewTap)block{
    
    self.imageViewTapBlock = block;
    
    if (self = [super initWithFrame:frame]) {
        self.placeholderImage = [UIImage imageNamed:placeholderImage];
        self.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        //self.pageDotColor = [UIColor whiteColor];
        self.currentPageDotColor = [UIColor orangeColor];
        
        self.delegate = self;
        //self.clipsToBounds = YES;
        self.bannerImageViewContentMode = UIViewContentModeScaleToFill;

    }
    return self;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    self.imageViewTapBlock(index);
}

@end
