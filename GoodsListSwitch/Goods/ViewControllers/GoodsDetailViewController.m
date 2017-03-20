//
//  GoodsDetailViewController.m
//  dfds
//
//  Created by fanxiaobin on 17/3/6.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "GoodInfoCell.h"
#import "GoodsOthersCell.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface GoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSDictionary *detailDic;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;



@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"4bigBackground"];
    [self.view addSubview:imageView];
    
    [self createTableView];
    
    [self duihuanGoodsBtn];
    
    [self requestGoodsDetailData];
    
    
    
}

//只刷新商品列表即可
- (void)requestGoodsDetailData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",@"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    NSDictionary *par = @{@"goodsId" : self.goodsId, @"currPage" : @"1", @"pageSize" : @"6"};
    [manager POST:@"http://192.168.0.121/eqMobile/delegateHandleRequest?OPT=7033" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"error"] integerValue] == 0) {
            
            NSArray *bannerList = responseObject[@"bannerList"];//imgUrl
            NSMutableArray *bannerArr = [NSMutableArray array];
            for (NSDictionary *bannerDic in bannerList) {
                [bannerArr addObject:bannerDic[@"imgUrl"] ? bannerDic[@"imgUrl"] : @""];
            }
            self.cycleScrollView.imageURLStringsGroup = bannerArr;
            
            self.detailDic = responseObject[@"exgoods"];
            
            
            
            [self.tableView reloadData];
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

#pragma mark -- 立即兑换
- (void)duihuanGoodsBtn{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kHeight - 50, kWidth, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"goodsDetail8"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(duihuanGoodsBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)duihuanGoodsBtnAction:(UIButton *)sender{
    NSLog(@"---- 立即兑换 --");
    
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 265.0 / 375.0 * kWidth)];
    headerView.userInteractionEnabled = YES;
    headerView.image = [UIImage imageNamed:@"goodsDetail2"];
    _tableView.tableHeaderView = headerView;
    
    self.cycleScrollView = [[SDCycleScrollView alloc] init];
    self.cycleScrollView.clipsToBounds = YES;
    self.cycleScrollView.layer.cornerRadius = 4;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"5financial_default"];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.pageDotColor = [UIColor orangeColor];
    [headerView addSubview:self.cycleScrollView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).insets(UIEdgeInsetsMake(0, 5, 10, 5));
    }];
    
    [_tableView registerClass:[GoodInfoCell class] forCellReuseIdentifier:@"GoodInfoCell"];
    [_tableView registerClass:[GoodsOthersCell class] forCellReuseIdentifier:@"GoodsOthersCell"];
    
    
    
    
    [self.view addSubview:_tableView];
    
}

#pragma mark ---- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 145.0f;
    }
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        GoodInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"GoodInfoCell"];
        infoCell.infoDic = self.detailDic;
        
        cell = infoCell;
        
    }else{
        GoodsOthersCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"GoodsOthersCell"];
        if (indexPath.row == 3) {
            otherCell.bgBorder.image = [UIImage imageNamed:@"goodsDetail7"];
            otherCell.rightLabel.textColor = [UIColor darkGrayColor];
            
        }else{
             otherCell.bgBorder.image = [UIImage imageNamed:@"goodsDetail6"];
            if (indexPath.row == 2) {
                otherCell.rightLabel.text = @"";
            }
        }
        
        NSArray *titleArr = @[@"",@"福豆换购",@"查看图文详情",@"送至 : "];
        otherCell.titleLabel.text = titleArr[indexPath.row];
        
        cell = otherCell;
    }
    
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}




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
