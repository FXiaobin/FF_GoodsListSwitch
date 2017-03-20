//
//  MoreGoodsViewController.m
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "MoreGoodsViewController.h"
#import "UIViewUtils.h"
#import <MJRefresh/MJRefresh.h>

#import <UIColor+Additions.h>

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIViewController+Loading.h"

#import "SDCycleBannerView.h"


@interface MoreGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic) NSInteger count;

@end

@implementation MoreGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"全部商品";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.view addSubview:self.tableView];
    
    [self updateDate];

    [self showLoading];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [UIViewUtils createTableViewWithFrame:CGRectMake(0, 0, 375, 667)
                                                    target:self style:UITableViewStylePlain
                                        isHeaderRefreshing:YES
                                       headerRefreshAction:@selector(updateDate)
                                          isFooterLoadMore:YES
                                      footerLoadMoreAction:@selector(loadMore)];
        
        SDCycleBannerView *b = [[SDCycleBannerView alloc] initWithFrame:CGRectMake(0, 0, 375, 200) placeholderImage:@"5financial_default" imageViewTap:^(NSInteger index) {
            NSLog(@"--- index= %ld",index);
        }];
        
        b.imageURLStringsGroup = @[
                                   @"http://img06.tooopen.com/images/20160727/tooopen_sl_172703871932.jpg",
                                   @"http://img06.tooopen.com/images/20161123/tooopen_sl_187628819897.jpg",
                                   @"http://img07.tooopen.com/images/20170306/tooopen_sl_200775855137.jpg"];
        
        _tableView.tableHeaderView = b;
        
    }
    return _tableView;
}

- (void)updateDate{
    
    //[self showLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
        self.count = 10;
        [_tableView reloadData];
        [self hiddenLoading];
    });
}

- (void)loadMore{
    //[self showLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_footer endRefreshing];
        self.count = 20;
        [_tableView reloadData];
        [self hiddenLoading];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
    
    cell.textLabel.text = @"发生的房间爱的";
    cell.detailTextLabel.text = @"kljkldas";
    
    cell.textLabel.textColor = [UIColor add_colorWithRGBHexValue:0x3cecec];
    cell.detailTextLabel.textColor = [UIColor add_colorWithRGBHexString:@"ef2233"];
    
    return cell;
}


//提示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"4emptyCell"];
}

- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
{
    return YES;
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

//提示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//是否可以滚动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//竖直方向上的整体偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
    return 140;
}
//控件之间的上下间距
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 30;
}

//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
