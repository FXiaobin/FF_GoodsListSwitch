//
//  PopMenuView.m
//  dfds
//
//  Created by fanxiaobin on 17/3/8.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "PopMenuView.h"

#define BG_View_Tag 85003345

@interface PopMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,copy) NSArray *titleArr;


@end

@implementation PopMenuView

-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleArr = titleArr;
        [self addSubview:self.tableView];
    }
    return self;
}


-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.titleArr[indexPath.row];
    if (self.menuViewClickBlock) {
        self.menuViewClickBlock(title, indexPath.row);
    }
    
    [self hiddenPopMenuView];
}

- (void)showPopMenuView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor blackColor];

    bgView.alpha = 0.0;
    bgView.tag = BG_View_Tag;
    [window addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenWindowTap:)];
    [bgView addGestureRecognizer:tap];

    [UIView animateWithDuration:0.2 animations:^{
        bgView.alpha = 0.6;
        bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
      
        
    } completion:^(BOOL finished) {
        [window addSubview:self];
    }];
   
}

- (void)hiddenWindowTap:(UITapGestureRecognizer *)sender{
    
    [self hiddenPopMenuView];
    
}

- (void)hiddenPopMenuView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [window viewWithTag:BG_View_Tag];
    [UIView animateWithDuration:0.2 animations:^{
        bgView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        bgView.alpha = 0.0;
    
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

@end
