//
//  MyFounctions.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyFounctions : NSObject
+(UIImage*) imageWithUIView:(UIView*) view;
+(CGFloat)calculateTextWidth:(NSString *)strContent fontsize:(CGFloat)fontsize;
+(CGFloat)calculateTextWidth:(NSString *)strContent font:(UIFont*)font;
+(CGFloat)calculateTextHeight:(NSString *)strContent font:(UIFont*)font;
+(CGFloat)calculateLabelHeightWithString:(NSString*)str Width:(CGFloat)width font:(UIFont*)font;
+(CGFloat)schoolDetailcalculateLabelHeightWithString:(NSString*)str Width:(CGFloat)width font:(UIFont*)font;
+(NSString*)md5:(NSString *)str;
+(NSString *)md5for32:(NSString *)str;
+(NSString*)getVendorIdentifier;
+(NSString *)getIPAddress:(BOOL)preferIPv4;
#pragma mark -------- user info
+(NSDictionary*)getUserInfo;
+(void)saveUserInfo:(NSDictionary*)user;
+(void)removeUserInfo;
+(NSMutableDictionary*)getCoachInfo;
+(void)saveCoachInfo:(NSMutableDictionary *)coach;
#pragma mark -------- log info
+(NSMutableDictionary*)getLogInfo;
+(void)saveLogInfo:(NSMutableDictionary *)log;
+(NSMutableDictionary*)getLogInfoPro4;
+(void)saveLogInfoPro4:(NSMutableDictionary *)log;
#pragma mark --------- message info
+(NSMutableArray*)getMessagesInfo;
+(void)saveMessagesInfo:(NSMutableArray*)msgs;
//base64
+(NSString*)encodeToBase64String:(UIImage *)image;
+(NSString *)base64StringFromText:(NSString *)text;
#pragma mark ------check identity card
+(BOOL)validateIdentityCard:(NSString *)identityCard;
+(BOOL)isValidateMobile:(NSString *)mobile;
#pragma mark ----------- date
+(NSUInteger)getMaxNumberOfDaysInCurrentMonth;
+(NSString*)timeStampToNormalTime:(NSString*)time;
+(NSString*)getTimeStamp;
+(NSInteger)getCurrentDateMonth;
+(NSInteger)getCurrentDateDay;
+(NSInteger)getCurrentDateWeekday;
+(NSInteger)getCurrentDateWeekdayWithSeperateDays:(NSInteger)days;
+(NSInteger)getDateDayWithSeperateDays:(NSInteger)days;
+(NSString*)getDateYearMonthDayWithSeperateDays:(NSInteger)days;
#pragma mark ------------ color to image
+(UIImage *)buttonHighlitedImage;
+(UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size;
//line view thin
+(void)setLineViewMoreThin:(UIView*)line;
//get sub view y
+(float)getSubviewFram_Y:(UIView*)subview OnAnySuperview:(UIView*)superview;
//percent view set
+(void)setPercentGrayview:(UIView*)grayView redView:(UIView*)redView percent:(NSInteger)percent;
+(BOOL)isPureNumandCharacters:(NSString *)string;
@end
