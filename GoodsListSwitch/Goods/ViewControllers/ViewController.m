//
//  ViewController.m
//  dfds
//
//  Created by fanxiaobin on 17/3/2.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "LeftCell.h"
#import "GoodsCollectionCell.h"
#import "GoodsTopCollectionCell.h"
#import "BannerReusableView.h"
#import "CollectionReusableHeaderView.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import <MJRefresh/MJRefresh.h>
#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
#import "MoreGoodsViewController.h"
#import "PopMenuView.h"
#import "CustomButton.h"

#define kHeight [UIScreen mainScreen].bounds.size.height
#define kWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSArray *bannersArr;
@property (nonatomic,strong) NSArray *bestExgoodsListArr; //其他分类中的为你推荐
@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) NSInteger curPage;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataArr = [NSMutableArray array];
    self.navigationItem.title = @"商品";
    self.curPage = 1;
    //self.view.backgroundColor = [UIColor yellowColor];
    
    
    
     
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"4bigBackground"];
    [self.view addSubview:imageView];
    
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(75, 64, kWidth - 75, kHeight -64 - 49)];
    UIImage *image= [UIImage imageNamed:@"goods7"];
    // 左端盖宽度
    NSInteger leftCapWidth = image.size.width * 0.5f;
    // 顶端盖高度
    NSInteger topCapHeight = image.size.height * 0.5f;
    // 重新赋值
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];

    backImage.image = image;
    backImage.userInteractionEnabled = YES;
    [self.view addSubview:backImage];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"item" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _selectedIndex = 0;
  
    [self createCollectionView];
    
    [self createTableView];
    
    [self requestHotRecommondGoodsListData];
    
    
    
//    CustomButton *b = [[CustomButton alloc] initWithFrame:CGRectMake(50, 80, 200, 50)];
//    b.backgroundColor = [UIColor yellowColor];
//    [b setImage:[UIImage imageNamed:@"goodsDetail5"] forState:UIControlStateNormal];
//    [b setTitle:@"测试" forState:UIControlStateNormal];
//    //b.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [b setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
//    [b setImageRect:CGRectMake(10, 25, 20, 20) titleRect:CGRectMake(10, 5, 40, 20) textAlignment:NSTextAlignmentCenter];
//    [self.view addSubview:b];
}

- (void)rightItemAction:(UIBarButtonItem *)sender{
    PopMenuView *menuView = [[PopMenuView alloc] initWithFrame:CGRectMake(kWidth - 120, 56, 100, 130) titleArr:@[@"对的",@"是的",@"额外"]];
    [menuView showPopMenuView];
    
    menuView.menuViewClickBlock = ^(NSString *title, NSInteger index){
        NSLog(@"---title = %@, index = %ld",title, (long)index);
    };
}

- (void)requestHotRecommondGoodsListData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",@"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    NSDictionary *par = @{@"currPage" : @(self.curPage), @"pageSize" : @"6"};
    [manager POST:@"http://192.168.0.121/eqMobile/delegateHandleRequest?OPT=7030" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self endRefreshing];
        
        if ([responseObject[@"error"] integerValue] == 0) {
            NSArray *excategoryList = responseObject[@"excategoryList"];
            [self.dataArr removeAllObjects];
            [self.dataArr addObject:@{@"catName": @"热门推荐"}];
            [self.dataArr addObjectsFromArray:excategoryList];
            self.bannersArr = responseObject[@"hotBestBannerList"];
            NSArray *exgoodsList = responseObject[@"exgoodsList"];
            if (self.isRefreshing) {
                [self.dataSource removeAllObjects];
            }
            
            for (NSDictionary *dic in exgoodsList) {
                GoodsModel *model = [GoodsModel makeModelWithDic:dic];
                [self.dataSource addObject:model];
            }
            
            [self.tableView reloadData];
            [self.collectionView reloadData];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self endRefreshing];
    }];
  
}

//只刷新商品列表即可
- (void)requestCateGoodsListDataWithCateID:(NSNumber *)cateId{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    NSSet *set = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",@"application/json;charset=UTF-8", @"application/x-www-form-urlencoded", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    
    NSDictionary *par = @{@"catId" : cateId, @"currPage" : @(self.curPage), @"pageSize" : @"4"};
    [manager POST:@"http://192.168.0.121/eqMobile/delegateHandleRequest?OPT=7031" parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"error"] integerValue] == 0) {
            self.bestExgoodsListArr = responseObject[@"bestExgoodsList"];
            self.bannersArr = responseObject[@"catBannerList"];
            NSArray *indexExgoodsList = responseObject[@"indexExgoodsList"];
            if (self.isRefreshing) {
                [self.dataSource removeAllObjects];
            }
            
            for (NSDictionary *dic in indexExgoodsList) {
                GoodsModel *model = [GoodsModel makeModelWithDic:dic];
                [self.dataSource addObject:model];
            }
        
            [self.collectionView reloadData];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self endRefreshing];
    }];
    
    
}


-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)createCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(78, 74, kWidth - 78.0, kHeight-74 -  49 - 20) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.contentInset = UIEdgeInsetsZero;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerClass:[GoodsCollectionCell class] forCellWithReuseIdentifier:@"GoodsCollectionCell"];
    [_collectionView registerClass:[GoodsTopCollectionCell class] forCellWithReuseIdentifier:@"GoodsTopCollectionCell"];
    [_collectionView registerClass:[BannerReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BannerReusableView"];[_collectionView registerClass:[CollectionReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableHeaderView"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateDate)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _collectionView.mj_header = header;
    
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_collectionView];
}

- (void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 100, kHeight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[LeftCell class] forCellReuseIdentifier:@"LeftCell"];
    
    [self.view addSubview:_tableView];
    
    
}

- (void)updateDate{
    self.curPage = 1;
    self.isRefreshing = YES;
    
    if (_selectedIndex == 0) {
        [self requestHotRecommondGoodsListData];
    }else{
        NSDictionary *dic = self.dataArr[_selectedIndex];
        NSNumber *cateId = dic[@"catId"];
        [self requestCateGoodsListDataWithCateID:cateId];
    }
}

- (void)loadMoreData{
    self.curPage += 1;
    self.isRefreshing = NO;
    
    if (_selectedIndex == 0) {
        [self requestHotRecommondGoodsListData];
    }else{
        NSDictionary *dic = self.dataArr[_selectedIndex];
        NSNumber *cateId = dic[@"catId"];
        [self requestCateGoodsListDataWithCateID:cateId];
    }
}

-(void)endRefreshing{
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
}

#pragma mark ---- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = self.dataArr[indexPath.row];
    cell.nameLabel.text = dic[@"catName"];
    
    if (_selectedIndex == indexPath.row) {
        cell.bottomIcon.image = [UIImage imageNamed:@"goods1"];
        
    }else{
        cell.bottomIcon.image = [UIImage imageNamed:@"goods2"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndex = indexPath.row;
    
    self.curPage = 1;
    self.isRefreshing = YES;
    [tableView reloadData];
    
    [self.dataSource removeAllObjects];
    
    if (_selectedIndex == 0) {
        [self requestHotRecommondGoodsListData];
    }else{
        NSDictionary *dic = self.dataArr[indexPath.row];
        NSNumber *cateId = dic[@"catId"];
        [self requestCateGoodsListDataWithCateID:cateId];
    }
}

#pragma mark ---- tableview
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_selectedIndex == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_selectedIndex == 0) {
        return self.dataSource.count;
    }else{
        if (section == 0) {
            return 1;
        }else{
            return self.dataSource.count;   //dataSouce;
        }
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedIndex != 0 && indexPath.section == 0) {
        ///推荐cell
        GoodsTopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsTopCollectionCell" forIndexPath:indexPath];
        [cell makeCellWithRecommondArray:self.bestExgoodsListArr];
        
        __weak typeof(self) weakSelf = self;
        cell.imageTapActionBlock = ^(NSInteger index){
            
            if (weakSelf.bestExgoodsListArr.count > index) {
                NSDictionary *dic = weakSelf.bestExgoodsListArr[indexPath.item];
                NSNumber *goodId = dic[@"id"];
                GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
                detailVC.goodsId = goodId;
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            }else{
                //敬请期待
                MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"敬请期待!";
                [hud hideAnimated:YES afterDelay:2.0];
            }
            
        };
        
        return cell;
      
    }else{
        GoodsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsCollectionCell" forIndexPath:indexPath];
        GoodsModel *model = self.dataSource[indexPath.row];
        cell.model = model;
        
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (_selectedIndex != 0) {
        if (indexPath.section == 0) {
            CGFloat width =  kWidth - 80;
            //第一组推荐商品高度自适应已计算
            CGFloat itemWidth = (kWidth - 90 - 4 * 10) / 3;
            CGFloat imageH = itemWidth * 72 / 80;
            CGFloat itemHeight = imageH + 40;
            CGFloat cellHeight = itemHeight + 20;
            return CGSizeMake(width, cellHeight);
        }
    }
    
    CGFloat itemW =  (kWidth - 80 - 30) / 2;
    return CGSizeMake(itemW, itemW + 40.0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section == 0) {
        BannerReusableView * headerView = (BannerReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BannerReusableView" forIndexPath:indexPath];
        headerView.bannerArr = self.bannersArr;
        
        return headerView;
        
    }else{
        
        CollectionReusableHeaderView *headerView = (CollectionReusableHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionReusableHeaderView" forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor orangeColor];
        
        __weak typeof(self) weakSelf = self;
        headerView.moreBtnActionBlock = ^(UIButton *sender){
            NSLog(@"--- 更多 ---");
            MoreGoodsViewController *moreVC = [[MoreGoodsViewController alloc]init];
            [weakSelf.navigationController pushViewController:moreVC animated:YES];
        };
        
        return headerView;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 80 - 20;
        return CGSizeMake(kWidth - 100, 116 / 276.0 * width + 10);
    }else{
        return CGSizeMake(kWidth - 100, 35);
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedIndex == 0) {  //默认首页 热门推荐
        GoodsModel *model = self.dataSource[indexPath.item];
        GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
        detailVC.goodsId = model.goodId;
        [self.navigationController pushViewController:detailVC animated:YES];
        
        
    }else{
        if (indexPath.section == 0) {
            //推荐商品
        
        }else{
            //全部商品
            GoodsModel *model = self.dataSource[indexPath.item];
            GoodsDetailViewController *detailVC = [[GoodsDetailViewController alloc] init];
            detailVC.goodsId = model.goodId;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
