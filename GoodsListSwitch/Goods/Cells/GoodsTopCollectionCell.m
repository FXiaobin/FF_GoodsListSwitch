//
//  GoodsTopCollectionCell.m
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodsTopCollectionCell.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface GoodsTopCollectionCell ()

@property (nonatomic,strong) UIImageView *bgBorder;
@property (nonatomic,strong) UIImageView *borderImageView1;
@property (nonatomic,strong) UIImageView *borderImageView2;
@property (nonatomic,strong) UIImageView *borderImageView3;

@end

@implementation GoodsTopCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       // [self setupUI];
        
        self.bgBorder = [UIImageView new];
        self.bgBorder.image = [UIImage imageNamed:@"goodsBackground"];
        self.bgBorder.userInteractionEnabled = YES;
        [self.contentView addSubview:self.bgBorder];
        
        [self.bgBorder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
        
        UIImageView *recommedIcon = [UIImageView new];
        recommedIcon.image = [UIImage imageNamed:@"recomend"];
        recommedIcon.userInteractionEnabled = YES;
        [self.contentView addSubview:recommedIcon];
        
        [recommedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.width.mas_equalTo(57);
            make.height.mas_equalTo(41);
        }];
        
    }
    
    return self;
}


-(void)makeCellWithRecommondArray:(NSArray *)recommondArr{
    
    for (UIView *subView in self.bgBorder.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat kWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (kWidth - 100 - 4 * 10) / 3;
    CGFloat imageH = itemWidth * 72 / 80;
    
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [UIImageView new];
        //width * 107 / 81
        imageView.frame = CGRectMake(10 + (itemWidth + 10) * i, 10.0, itemWidth, imageH + 40);
        imageView.image = [UIImage imageNamed:@"goods7"];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 1020 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:tap];
        
        [self.bgBorder addSubview:imageView];
        
        UIImageView *goodsIcon = [UIImageView new];
        goodsIcon.image = [UIImage imageNamed:@"bigBackground"];
        goodsIcon.userInteractionEnabled = YES;
        [imageView addSubview:goodsIcon];
        
        [goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.and.right.equalTo(imageView).offset(0.0);
            make.height.mas_equalTo(imageView.mas_width).multipliedBy(72.0/80);
        }];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:9.0];
        titleLabel.textColor = [UIColor brownColor];
        titleLabel.text = @"苹果iPhone7 Plus 亮黑";
        [imageView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsIcon.mas_bottom).offset(2.0);
            make.left.equalTo(goodsIcon.mas_left).offset(5.0);
            make.right.equalTo(goodsIcon.mas_right).offset(-5.0);
        }];
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.font = [UIFont boldSystemFontOfSize:12.0];
        countLabel.textColor = [UIColor brownColor];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.text = @"9000钻石";
        countLabel.textColor = [UIColor redColor];
        [imageView addSubview:countLabel];
        
        [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(0.0);
            make.left.equalTo(imageView.mas_left).offset(0.0);
            make.right.equalTo(imageView.mas_right).offset(0.0);
            make.bottom.equalTo(imageView.mas_bottom).offset(-8.0);
        }];
        
        
        if (recommondArr.count > i) {
            NSDictionary *dic = recommondArr[i];
            [goodsIcon sd_setImageWithURL:[NSURL URLWithString:dic[@"goodsThumb"]] placeholderImage:[UIImage imageNamed:@"bigBackground"]];
            titleLabel.text = dic[@"goodsName"] ? dic[@"goodsName"] : @"";
            countLabel.text = dic[@"marketPrice"] ? [NSString stringWithFormat:@"%@钻石",dic[@"marketPrice"]] : @"";
        }else{
            
            titleLabel.text = @"敬请期待";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:15];
            countLabel.text = @"";
        }
    }

}

- (void)imageTapAction:(UITapGestureRecognizer *)sender{
    NSInteger tag = sender.view.tag - 1020;
    if (self.imageTapActionBlock) {
        self.imageTapActionBlock(tag);
    }
    
}

@end
