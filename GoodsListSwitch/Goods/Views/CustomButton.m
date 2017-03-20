//
//  CustomButton.m
//  dfds
//
//  Created by fanxiaobin on 17/3/16.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton ()

@property (nonatomic) CGRect imageRect;

@property (nonatomic) CGRect titleRect;

@property (nonatomic) NSTextAlignment textAlignment;

@end

@implementation CustomButton

-(void)setImageRect:(CGRect)imageRect titleRect:(CGRect)titleRect textAlignment:(NSTextAlignment)textAlignment{
    _imageRect = imageRect;
    _titleRect = titleRect;
    _textAlignment = textAlignment;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if ((_imageRect.size.width != 0) || (_imageRect.size.height != 0)) {
        self.imageView.frame = _imageRect;
    }
    if ((_titleRect.size.width != 0) || (_titleRect.size.height != 0)) {
        self.titleLabel.frame = _titleRect;
        self.titleLabel.textAlignment = _textAlignment;
    }
    
}

@end
