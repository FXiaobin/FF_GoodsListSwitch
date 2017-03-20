//
//  DiscoveryViewController.m
//  dfds
//
//  Created by liwei on 17/3/8.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()

@property (nonatomic,strong) UILabel *aUILabel;

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    self.aUILabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, 300, 20)];
//    self.aUILabel.text = @"滚动label测试数据";
//    self.aUILabel.backgroundColor = [UIColor orangeColor];
//    self.aUILabel.textColor = [UIColor whiteColor];
//    
//    [self.view addSubview:self.aUILabel];
//    
//    [self startAnimationIfNeeded];
    
    
    
    // 获取文本
    NSString *string = @"  喜欢这首情思幽幽的曲子，仿佛多么遥远，在感叹着前世的情缘，又是那么柔软，在祈愿着来世的缠绵。《莲的心事》，你似琉璃一样的晶莹，柔柔地拨动我多情的心弦。我，莲的心事，有谁知？我，莲的矜持，又有谁懂？  ";
    
    // 初始化label
    UILabel *label	  = [UILabel new];
    label.text		  = string;
    label.numberOfLines = 0;
    label.textColor	 = [UIColor cyanColor];
    //label.font		  = [UIFont fontWithName:CUSTOM_FONT(@"新蒂小丸子体", 0) size:20.f];
    
    // 计算尺寸
    CGSize size		 = [label sizeThatFits:CGSizeMake(0, 0)];
    label.frame		 = (CGRect){CGPointZero, size};
    
    // 初始化ScrollView
    UIScrollView *showView = \
    [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, 320, size.height)];
    showView.contentSize   = size;
    showView.showsHorizontalScrollIndicator = NO;
    [showView addSubview:label];
    [self.view addSubview:showView];
    
    // 形成边缘的遮罩
    UIImageView *imageView = \
    [[UIImageView alloc] initWithFrame:CGRectMake(0, 90, 320, size.height)];
    imageView.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:imageView];
    
    // 动画
    [UIView animateKeyframesWithDuration:10
                                   delay:7
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                              animations:^{
                                  // 计算移动的距离
                                  CGPoint point = showView.contentOffset;
                                  point.x = size.width - 320.f;
                                  showView.contentOffset = point;
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
    
    
}

//-(void)startAnimationIfNeeded{
//    //取消、停止所有的动画
//    [self.aUILabel.layer removeAllAnimations];
//    CGSize textSize = [self.aUILabel.text sizeWithFont:self.aUILabel.font];
//    CGRect lframe = self.aUILabel.frame;
//    lframe.size.width = textSize.width;
//    self.aUILabel.frame = lframe;
//    const float oriWidth = 180;
//    if (textSize.width > oriWidth) {
//        float offset = textSize.width - oriWidth;
//        [UIView animateWithDuration:3.0
//                              delay:0
//                            options:UIViewAnimationOptionRepeat //动画重复的主开关
//         |UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
//         |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
//                         animations:^{
//                             self.aUILabel.transform = CGAffineTransformMakeTranslation(-offset, 0);
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }
//         ];
//    }
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
