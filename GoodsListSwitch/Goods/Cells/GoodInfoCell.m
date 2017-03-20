//
//  GoodInfoCell.m
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodInfoCell.h"
#import <Masonry.h>
#import "CustomButton.h"

@interface GoodInfoCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *shortLine;
@property (nonatomic,strong) UIImageView *topLine;
@property (nonatomic,strong) CustomButton *attentBtn;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *saleLabel;
@property (nonatomic,strong) UIImageView *saleHerLine;
@property (nonatomic,strong) UIImageView *bottomLine;
@property (nonatomic,strong) UILabel *serverLabel;
@property (nonatomic,strong) UILabel *attentLabel;
@property (nonatomic,strong) UILabel *saleCountLabel;

@end

@implementation GoodInfoCell

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

-(void)setupUI{
    
    UIImageView *borderImageView = [UIImageView new];
    UIImage *image= [UIImage imageNamed:@"goodsBackground"];
    // 左端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.4f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.4f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
   
    borderImageView.image = image;
    borderImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:borderImageView];
    
    [borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textColor = [UIColor brownColor];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.text = @"苹果iPhone7 Plus 亮黑";
    [borderImageView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(borderImageView).offset(10.0);
        make.left.equalTo(borderImageView.mas_left).offset(15.0);
        make.right.equalTo(borderImageView.mas_right).offset(-85.0);
        make.height.mas_equalTo(40.0);
    }];
    
    self.shortLine = [[UIImageView alloc] init];
    self.shortLine.backgroundColor = [UIColor brownColor];
    [borderImageView addSubview:self.shortLine];
    
    [self.shortLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel).offset(10.0);
        make.left.equalTo(self.titleLabel.mas_right).offset(10.0);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(30.0);
    }];
    
    self.attentBtn = [[CustomButton alloc] init];
    [self.attentBtn setTitle:@"关注" forState:UIControlStateNormal];
    [self.attentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.attentBtn setImage:[UIImage imageNamed:@"goodsDetail4"] forState:UIControlStateNormal];
    self.attentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self.attentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [borderImageView addSubview:self.attentBtn];
    
    [self.attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel).offset(0.0);
        make.left.equalTo(self.shortLine.mas_right).offset(10.0);
        make.right.equalTo(borderImageView.mas_right).offset(-15.0);
        make.height.mas_equalTo(50.0);
    }];
    [self.attentBtn setImageRect:CGRectMake(10, 5, 20, 20) titleRect:CGRectMake(0, 25, 40, 20) textAlignment:NSTextAlignmentCenter];
    
    self.topLine = [[UIImageView alloc] init];
    self.topLine.backgroundColor = [UIColor brownColor];
    [borderImageView addSubview:self.topLine];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10.0);
        make.left.equalTo(self.titleLabel.mas_left).offset(0.0);
        make.right.equalTo(borderImageView.mas_right).offset(-15.0);
        make.height.mas_equalTo(0.5);
    }];
    
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.countLabel.textColor = [UIColor redColor];
    self.countLabel.text = @"939000 钻石";
    [borderImageView addSubview:self.countLabel];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLine.mas_bottom).offset(5.0);
        make.left.equalTo(self.titleLabel.mas_left).offset(0.0);
        make.height.mas_equalTo(25.0);
    }];
    
    self.saleLabel = [[UILabel alloc] init];
    self.saleLabel.font = [UIFont systemFontOfSize:14.0];
    self.saleLabel.textColor = [UIColor brownColor];
    self.saleLabel.text = @"售价 : ¥939";
    self.saleLabel.textAlignment = NSTextAlignmentRight;
    [borderImageView addSubview:self.saleLabel];
    
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countLabel);
        make.right.equalTo(borderImageView.mas_right).offset(-15.0);
        make.width.mas_equalTo(150.0);
        make.height.mas_equalTo(20.0);
    }];
    
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.image = [UIImage imageNamed:@"goodsDetaildashed"];
    [borderImageView addSubview:self.bottomLine];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.saleLabel.mas_bottom).offset(5.0);
        make.left.equalTo(self.titleLabel.mas_left).offset(0.0);
        make.right.equalTo(self.saleLabel.mas_right).offset(0.0);
        make.height.mas_equalTo(1.0);
    }];
    
    self.serverLabel = [[UILabel alloc] init];
    self.serverLabel.font = [UIFont systemFontOfSize:13.0];
    self.serverLabel.textColor = [UIColor brownColor];
    self.serverLabel.text = @"财富地图售后服务";
    [borderImageView addSubview:self.serverLabel];
    
    [self.serverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomLine.mas_bottom).offset(6.0);
        make.left.equalTo(self.titleLabel.mas_left).offset(0.0);
        make.height.mas_equalTo(20);
    }];
    
    self.attentLabel = [[UILabel alloc] init];
    self.attentLabel.font = [UIFont systemFontOfSize:13.0];
    self.attentLabel.textColor = [UIColor brownColor];
    self.attentLabel.text = @"关注 : 100";
    [borderImageView addSubview:self.attentLabel];
    
    [self.attentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serverLabel).offset(0.0);
        make.centerX.equalTo(borderImageView);
        make.height.mas_equalTo(20);
    }];
    
    self.saleCountLabel = [[UILabel alloc] init];
    self.saleCountLabel.font = [UIFont systemFontOfSize:13.0];
    self.saleCountLabel.textColor = [UIColor brownColor];
    self.saleCountLabel.text = @"销量 : 8980";
    [borderImageView addSubview:self.saleCountLabel];
    
    [self.saleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.attentLabel);
        make.right.equalTo(borderImageView.mas_right).offset(-15.0);
        make.height.mas_equalTo(20);
    }];
 
}


-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    
    self.titleLabel.text = infoDic[@"goodsName"];
    
    
    if (infoDic[@"isCollect"]) {
        [self.attentBtn setImage:[UIImage imageNamed:@"goodsDetail5"] forState:UIControlStateNormal];
    }else{
        [self.attentBtn setImage:[UIImage imageNamed:@"goodsDetail4"] forState:UIControlStateNormal];
    }
    
    self.countLabel.text =  [NSString stringWithFormat:@"%@ 钻石", infoDic[@"shopDiamonds"]];
    self.saleLabel.text = [NSString stringWithFormat:@"售价 : %@", infoDic[@"marketPrice"]];
    self.attentLabel.text = [NSString stringWithFormat:@"关注 : %@",infoDic[@"collectNum"]];
    
    if ([infoDic[@"limitNum"] integerValue] > 0) {
        self.saleCountLabel.text = [NSString stringWithFormat:@"限购%@次",infoDic[@"limitNum"]];
    }else{
        self.saleCountLabel.text = @"不限购";
    }
    
    
}

@end
