//
//  CommonUtils.m
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "CommonUtils.h"

#define HISTORY_SEARCH_STRING   @"historySearchString"
#define MAIN_FONT(fontSize)     [UIFont systemFontOfSize:fontSize]
#define MAIN_COLOR              [UIColor orangeColor]

@implementation CommonUtils



+(CommonUtils *)manager{
    return [[CommonUtils alloc] init];
}

/*
+ (void)goUserLoginWithTarget:(UIViewController *)target{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [target presentViewController:loginVC animated:YES completion:nil];
}*/

#pragma mark --- 添加 边框 圆角 点击事件
+ (void)cornerRadius:(CGFloat)cornerRadius forView:(UIView *)aview{
    
    aview.clipsToBounds = YES;
    aview.layer.cornerRadius = cornerRadius;
}

+ (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)aview{
    aview.layer.borderColor = borderColor.CGColor;
    aview.layer.borderWidth = borderWidth;
}

+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView{
    aView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:@selector(selector)];
    [aView addGestureRecognizer:tap];
}


#pragma mark --- 属性字符串
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)fontSize range:(NSRange)range{
    
    NSMutableAttributedString *attribitedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attribitedStr addAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : MAIN_FONT(fontSize)} range:range];
    
    return attribitedStr;
}

+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content attributes:@{NSParagraphStyleAttributeName : paragraph}];
    return attributedStr;
}

+ (CGSize)sizeWithContent:(NSString *)content attributed:(NSDictionary *)attributedDic limitedSize:(CGSize)limitSize{
    
    CGRect rect = [content boundingRectWithSize:limitSize
                                        options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                     attributes:attributedDic context:nil];
    
    return rect.size;
}


#pragma mark --- 导航条颜色修改
+ (void)navigationBarSetWithTargetVC:(UIViewController *)targetVC isWhite:(BOOL)isWhite{
    
    UIColor *mainColor = MAIN_COLOR;
    UIColor *tintColor = [UIColor whiteColor];
    NSString *indicatorImage = @"nav_back_white";
    [targetVC.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont fontWithName:@"PingFang SC" size:17]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [targetVC.navigationController.navigationBar setBarTintColor:mainColor];
    [targetVC.navigationController.navigationBar setTintColor:tintColor];
    [[UINavigationBar appearance] setTintColor:tintColor ];
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:indicatorImage];
    [UINavigationBar appearance].backIndicatorTransitionMaskImage = [UIImage imageNamed:indicatorImage];
    
//    [targetVC.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:mainColor] forBarMetrics:UIBarMetricsDefault];
//    [targetVC.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:mainColor]];
}

#pragma mark --- 保存图片至相册
- (void)saveImageToPhotoLibraryWithImage:(UIImage *)image completeBlock:(resultBlock)block{
    self.commonUtilsBlock = block;
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (self.commonUtilsBlock) {
        self.commonUtilsBlock(error);
    }
}

#pragma mark ---  添加的 常用的
#pragma mark --- NSDate

#define Date_MINUTE	60
#define Date_HOUR		3600
#define Date_DAY		86400
#define Date_WEEK		604800
#define Date_YEAR		31556926

+ (NSString *)timeStringGetWithDate:(NSDate *)date{
    NSString *timeStr;
    NSDate *todayDate = [NSDate date];
    NSTimeInterval seconds = [todayDate timeIntervalSinceDate:date];
    
    if (seconds < Date_MINUTE) {
        timeStr = [NSString stringWithFormat:@"%d秒前",(int)seconds];
    }else if (seconds < Date_HOUR){
        seconds /= Date_MINUTE;
        timeStr = [NSString stringWithFormat:@"%d分钟前",(int)seconds];
    }else if (seconds < Date_DAY){
        seconds /= Date_HOUR;
        timeStr = [NSString stringWithFormat:@"%d小时前",(int)seconds];
    }else if (seconds < Date_WEEK){
        seconds /= Date_DAY;
        timeStr = [NSString stringWithFormat:@"%d天前",(int)seconds];
    }else if (seconds < Date_YEAR){
        seconds /= Date_WEEK;
        timeStr = [NSString stringWithFormat:@"%d周前",(int)seconds];
    }else{
        seconds /= Date_YEAR;
        timeStr = [NSString stringWithFormat:@"%d年前",(int)seconds];
    }
    return timeStr;
}

//某个日期对应的时间戳，精确到毫秒
+ (NSTimeInterval)timeIntervalNowTo1970WithDate:(NSDate *)date{
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval * 1000.0;
}

// dateFormatter字符串yyyyMMddTHHmmss，记住你中间有个T
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 设置为UTC时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSDate *date = [formatter dateFromString:dateFormatter];
    
    return date;
}

/**
 *  日期格式化
 *
 *  @param date          某个日期
 *  @param dateFormatter 要显示的格式 常用的有：YYYY-MM-dd HH:mm:ss  YYYY/MM/dd HH:mm:ss 和 yyyyMMddHHmmssSSS
 *
 *  @return 某个格式的日期字符串
 */
+ (NSString *)timeFormatterStringWithDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    NSString *timeStr = [formatter stringFromDate:date];
    
    return timeStr;
}

//将时间戳格式化成字符串
+ (NSString *)timeFormatterStringWithTimestamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)dateFormatter{
    //timestamp += 8 * 60 * 60;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeFormatterStr = [self timeFormatterStringWithDate:date dateFormatter:dateFormatter];
    return timeFormatterStr;
}



#pragma mark --- 搜索
+ (void)saveSearchString:(NSString *)searchString{
    
    NSArray *historyArr = [self fetchHistorySearchResultArray];
    
    NSMutableArray *array = [NSMutableArray array];
    if (historyArr.count ) {
        [array addObjectsFromArray:historyArr];
    }
    [array addObject:searchString];
    
    NSSet *set = [NSSet setWithArray:array];
    NSArray *hArray = [NSArray arrayWithArray:set.allObjects];
    
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:hArray];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}

+ (NSArray *)fetchHistorySearchResultArray{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *historyData = [ud objectForKey:HISTORY_SEARCH_STRING];
    NSArray *historyArr = [NSKeyedUnarchiver unarchiveObjectWithData:historyData];
    
    return historyArr;
}

+ (void)clearAllHistorySearchString{
    
    NSArray *historyArr = @[];
    NSData *historyData = [NSKeyedArchiver archivedDataWithRootObject:historyArr];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:historyData forKey:HISTORY_SEARCH_STRING];
    [ud synchronize];
}





@end
