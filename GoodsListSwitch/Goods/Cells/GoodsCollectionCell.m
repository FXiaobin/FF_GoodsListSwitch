//
//  GoodsCollectionCell.m
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodsCollectionCell.h"
#import <Masonry.h>
#import "GoodsModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GoodsCollectionCell ()

///商品图片
@property (nonatomic,strong) UIImageView *goodsIcon;
///商品标题
@property (nonatomic,strong) UILabel *titleLabel;
///钻石数量
@property (nonatomic,strong) UILabel *countLabel;


@end

@implementation GoodsCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI{
   
    UIImageView *borderImageView = [UIImageView new];
    borderImageView.image = [UIImage imageNamed:@"goods7"];
    borderImageView.userInteractionEnabled = YES;
     [self.contentView addSubview:borderImageView];
    
    [borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsZero);
    }];
    
    
    self.goodsIcon = [UIImageView new];
    self.goodsIcon.image = [UIImage imageNamed:@"bigBackground"];
    self.goodsIcon.userInteractionEnabled = YES;
    self.goodsIcon.clipsToBounds = YES;
    self.goodsIcon.layer.cornerRadius = 4;
    self.goodsIcon.contentMode = UIViewContentModeScaleToFill;
    [borderImageView addSubview:self.goodsIcon];
    
    [self.goodsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(borderImageView).offset(8.0);
        make.right.equalTo(borderImageView.mas_right).offset(-8.0);
        make.height.mas_equalTo(self.goodsIcon.mas_width);
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:11.0];
    self.titleLabel.textColor = [UIColor brownColor];
    self.titleLabel.text = @"苹果iPhone7 Plus 亮黑";
    [borderImageView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsIcon.mas_bottom).offset(2.0);
        make.left.equalTo(self.goodsIcon.mas_left).offset(0.0);
        make.right.equalTo(self.goodsIcon.mas_right).offset(0.0);
    }];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.countLabel.textColor = [UIColor brownColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.text = @"9000钻石";
    self.countLabel.textColor = [UIColor redColor];
    [borderImageView addSubview:self.countLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2.0);
        make.left.equalTo(self.goodsIcon.mas_left).offset(0.0);
        make.right.equalTo(self.goodsIcon.mas_right).offset(0.0);
        make.bottom.equalTo(borderImageView.mas_bottom).offset(-10.0);
    }];

}

-(void)setModel:(GoodsModel *)model{
    _model = model;
    
    
    [self.goodsIcon sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:[UIImage imageNamed:@"bigBackground"]];
    self.titleLabel.text = model.goodsName ? model.goodsName : @"";
    self.countLabel.text = model.shopDiamonds ? [NSString stringWithFormat:@"%@钻石",model.shopDiamonds] : @"";
}

@end
