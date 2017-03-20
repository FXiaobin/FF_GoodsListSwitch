//
//  GoodsOthersCell.m
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodsOthersCell.h"
#import <Masonry.h>

@implementation GoodsOthersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.bgBorder = [UIImageView new];
    self.bgBorder.image = [UIImage imageNamed:@"goodsDetail6"];
    [self.contentView addSubview:self.bgBorder];
    
    [self.bgBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"福豆换购";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.bgBorder addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15.0);
        make.centerY.equalTo(self.bgBorder);
        make.height.mas_equalTo(30.0);
    }];
    
    
    self.rightLabel = [UILabel new];
    self.rightLabel.text = @"钻石不足?用福豆大挪移";
    self.rightLabel.font = [UIFont boldSystemFontOfSize:13];
    self.rightLabel.textColor = [UIColor orangeColor];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [self.bgBorder addSubview:self.rightLabel];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(15.0);
        make.right.equalTo(self.bgBorder.mas_right).offset(-30.0);
        make.centerY.equalTo(self.bgBorder);
        make.height.mas_equalTo(30.0);
    }];
    
}

@end
