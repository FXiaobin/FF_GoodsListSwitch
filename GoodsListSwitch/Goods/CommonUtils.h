//
//  CommonUtils.h
//  dfds
//
//  Created by fanxiaobin on 17/3/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^resultBlock)(id object);


@interface CommonUtils : NSObject

@property (nonatomic,copy) resultBlock commonUtilsBlock;

+ (CommonUtils *)manager;

+ (void)goUserLoginWithTarget:(UIViewController *)target;

///视图边框 圆角 添加点击事件
+ (void)cornerRadius:(CGFloat)cornerRadius forView:(UIView *)aview;
+ (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)aview;
+ (void)addTarget:(id)target selector:(SEL)selector forView:(UIView *)aView;

///导航条颜色设置
+ (void)navigationBarSetWithTargetVC:(UIViewController *)targetVC isWhite:(BOOL)isWhite;


///属性字符串
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)text color:(UIColor *)color fontSize:(CGFloat)fontSize range:(NSRange)range;
+ (CGSize)sizeWithContent:(NSString *)content attributed:(NSDictionary *)attributedDic limitedSize:(CGSize)limitSize;
+ (NSAttributedString *)paragraphStyleWithContent:(NSString *)content lineSpacing:(CGFloat)lineSpacing;


//NSDate 常用的
+ (NSString *)timeStringGetWithDate:(NSDate *)date;
+ (NSTimeInterval)timeIntervalNowTo1970WithDate:(NSDate *)date;
+ (NSDate *)dateWithTimeDateFormatter:(NSString *)dateFormatter;
+ (NSString *)timeFormatterStringWithDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter;
+ (NSString *)timeFormatterStringWithTimestamp:(NSTimeInterval)timestamp dateFormatter:(NSString *)dateFormatter;

///保存图片到相册
- (void)saveImageToPhotoLibraryWithImage:(UIImage *)image completeBlock:(resultBlock)block;


///搜索历史保存
+ (void)saveSearchString:(NSString *)searchString;
+ (NSArray *)fetchHistorySearchResultArray;
+ (void)clearAllHistorySearchString;




@end
