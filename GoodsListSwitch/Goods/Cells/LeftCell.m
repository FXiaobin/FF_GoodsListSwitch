//
//  LeftCell.m
//  dfds
//
//  Created by fanxiaobin on 17/3/2.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "LeftCell.h"

@implementation LeftCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    
    self.bottomIcon = [[UIImageView alloc] init];
    self.bottomIcon.frame = CGRectMake(0, 0, 95.0, 44);
    self.bottomIcon.image = [UIImage imageNamed:@"goods2"];
    [self.contentView addSubview:self.bottomIcon];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    
}

@end
