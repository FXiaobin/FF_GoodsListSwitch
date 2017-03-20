//
//  CollectionReusableHeaderView.m
//  dfds
//
//  Created by fanxiaobin on 17/3/4.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "CollectionReusableHeaderView.h"
#import <Masonry.h>


@interface CollectionReusableHeaderView ()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *moreBtn;

@end

@implementation CollectionReusableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        /*
         for (NSString *fontFamilyName in [UIFont familyNames]) {
         NSLog(@"--- %@ ---", fontFamilyName);
         for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
         NSLog(@"  %@", fontName);
         }
         NSLog(@"   ");
         }
         */
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, [UIScreen mainScreen].bounds.size.width - 85 - 10, 130 - 10)];
        self.titleLabel.text = @"全部商品";
        self.titleLabel.textColor = [UIColor whiteColor];
        //FZSEJW--GB1-0  FZZHYJW--GB1-0
        self.titleLabel.font = [UIFont fontWithName:@"FZShaoEr-M11S" size:16];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(6);
            make.bottom.equalTo(self).offset(-6);
            make.width.mas_equalTo(75.0);
        }];
        
        
        self.moreBtn = [[UIButton alloc] init];
        [self.moreBtn setTitle:@"更多 >" forState:UIControlStateNormal];
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.moreBtn.clipsToBounds = YES;
        self.moreBtn.layer.cornerRadius = 10;
        self.moreBtn.layer.borderWidth = 0.5;
        self.moreBtn.layer.borderColor = [UIColor brownColor].CGColor;
        [self.moreBtn addTarget:self action:@selector(moreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.moreBtn];
        
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-10.0);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

- (void)moreBtnAction:(UIButton *)sender{
    if (self.moreBtnActionBlock) {
        self.moreBtnActionBlock(sender);
    }
}

@end
