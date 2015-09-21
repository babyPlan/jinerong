//
//  MyFounctions.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyFounctions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#define     LocalStr_None           @""
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation MyFounctions
+(UIImage*) imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

+(CGFloat)calculateTextWidth:(NSString *)strContent fontsize:(CGFloat)fontsize
{
    CGSize size = [strContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]}];
    return size.width;
}

+(CGFloat)calculateTextWidth:(NSString *)strContent font:(UIFont*)font
{
    CGSize size = [strContent sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}
+(CGFloat)calculateTextHeight:(NSString *)strContent font:(UIFont*)font
{
    CGSize size = [strContent sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.height;
}

+(CGFloat)calculateLabelHeightWithString:(NSString*)str Width:(CGFloat)width font:(UIFont*)font
{
    //calculate heighgt
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    // end
    
    return labelSize.height;
}
+(CGFloat)schoolDetailcalculateLabelHeightWithString:(NSString*)str Width:(CGFloat)width font:(UIFont*)font
{
    //calculate heighgt
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5.0];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    // end
    return labelSize.height;
    
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+ (NSString *)md5for32:(NSString *)str {
    
    
    
    const char *cStr = [str UTF8String];
    
    
    
    unsigned char result[32];
    
    
    
    CC_MD5( cStr, strlen(cStr), result );
    
    
    
    return [NSString stringWithFormat:
            
            
            
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}
+(NSString*)getVendorIdentifier
{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}
+(NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+(NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
#pragma mark -------- user info
+(NSMutableDictionary*)getUserInfo
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/user",[array objectAtIndex: 0]];
    NSMutableDictionary *user= [[NSKeyedUnarchiver unarchiveObjectWithFile:savePath] objectAtIndex:0];
    return user;
}
+(void)saveUserInfo:(NSMutableDictionary *)user
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/user",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:[NSArray arrayWithObject:user] toFile:savePath];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUser" object:nil userInfo:nil];
}
+(void)removeUserInfo
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/user",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/portrait",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/portrait",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]] error:nil];
    }
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUser" object:nil userInfo:nil];
}
+(NSMutableDictionary*)getCoachInfo
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/coach",[array objectAtIndex: 0]];
    NSMutableDictionary *user= [[NSKeyedUnarchiver unarchiveObjectWithFile:savePath] objectAtIndex:0];
    return user;
}
+(void)saveCoachInfo:(NSMutableDictionary *)coach
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/coach",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:[NSArray arrayWithObject:coach] toFile:savePath];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUser" object:nil userInfo:nil];
}

#pragma mark -------- log info
+(NSMutableDictionary*)getLogInfo
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/log",[array objectAtIndex: 0]];
    NSMutableDictionary *log= [[NSKeyedUnarchiver unarchiveObjectWithFile:savePath] objectAtIndex:0];
    return log;
}
+(void)saveLogInfo:(NSMutableDictionary *)log
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/log",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:[NSArray arrayWithObject:log] toFile:savePath];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUser" object:nil userInfo:nil];
}
+(NSMutableDictionary*)getLogInfoPro4
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/logPro4",[array objectAtIndex: 0]];
    NSMutableDictionary *log= [[NSKeyedUnarchiver unarchiveObjectWithFile:savePath] objectAtIndex:0];
    return log;
}
+(void)saveLogInfoPro4:(NSMutableDictionary *)log
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/logPro4",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:[NSArray arrayWithObject:log] toFile:savePath];
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUser" object:nil userInfo:nil];
}
#pragma mark ---------- messages
+(NSMutableArray *)getMessagesInfo
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/messages",[array objectAtIndex: 0]];
    NSMutableArray *msg= [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
    return msg;
}
+(void)saveMessagesInfo:(NSMutableArray *)msgs
{
    NSArray* array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString* savePath = [NSString stringWithFormat:@"%@/messages",[array objectAtIndex: 0]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [NSKeyedArchiver archiveRootObject:msgs toFile:savePath];
}

#pragma mark ---------- base64
+(NSString *)encodeToBase64String:(UIImage *)image
{
    NSString *baseStr = [UIImageJPEGRepresentation(image,1) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //remove special char
    NSString *baseString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)baseStr,
                                                                                         NULL,
                                                                                         CFSTR(":/?#[]@!$&’()*+,;="),
                                                                                         kCFStringEncodingUTF8);
    return baseString;
}
+ (NSString *)base64StringFromText:(NSString *)text
{
    if (text && ![text isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSUTF8StringEncoding freeWhenDone:YES];
}
#pragma mark ------mobile number check
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18,14开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]|(14[57])))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}
#pragma mark ------check identity card
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
#pragma mark ----------- date
+(NSUInteger)getMaxNumberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
}
+(NSString *)timeStampToNormalTime:(NSString *)time
{
    NSString *str=[time substringToIndex:10];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str longLongValue]];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *fixString = [dateFormatter stringFromDate:confromTimesp];
    
    NSString *mytime=fixString;
    return mytime;
}
+(NSString*)getTimeStamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}
+(NSInteger)getCurrentDateMonth//get calender month
{
    NSDate *  senddate=[NSDate date];
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    //    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    //    NSInteger day=[conponent day];
    //    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
    return month;
}
+(NSInteger)getCurrentDateDay//get calender day
{
    NSDate *  senddate=[NSDate date];
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    //    NSInteger year=[conponent year];
    //    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    //    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
    return day;
}
+(NSInteger)getCurrentDateWeekday
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    return weekday;
}
+(NSInteger)getCurrentDateWeekdayWithSeperateDays:(NSInteger)days
{
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:days*60*60*24];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
                        fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    return weekday;
}
+(NSInteger)getDateDayWithSeperateDays:(NSInteger)days//get other day
{
    NSDate *  senddate=[[NSDate date] dateByAddingTimeInterval:days*60*60*24];
    //    [senddate dateByAddingTimeInterval:(NSTimeInterval)]
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    //    NSInteger year=[conponent year];
    //    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    //    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
    return day;
}
+(NSString*)getDateYearMonthDayWithSeperateDays:(NSInteger)days//get other day
{
    NSDate *  senddate=[[NSDate date] dateByAddingTimeInterval:days*60*60*24];
    //    [senddate dateByAddingTimeInterval:(NSTimeInterval)]
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4d-%2d-%2d",year,month,day];
    return nsDateString;
}
#pragma mark --------- color to image
+(UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
+(UIImage *)buttonHighlitedImage
{
    return [self imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(20, 20)];
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *alphaImage=[self imageByApplyingAlpha:0.6 image:image];
    return alphaImage;
    
}
+(void)setLineViewMoreThin:(UIView*)line
{
    if (line.frame.size.height==1.0)
    {
        [line setFrame:CGRectMake(PARENT_X(line), PARENT_Y(line), PARENT_WIDTH(line), 0.5)];
    }
    else if (line.frame.size.width==1.0)
    {
        [line setFrame:CGRectMake(PARENT_X(line), PARENT_Y(line), 0.5, PARENT_HEIGHT(line))];
    }
}
+(float)getSubviewFram_Y:(UIView*)subview OnAnySuperview:(UIView*)superview
{
    CGRect rect = [subview convertRect:subview.frame toView:superview];
//    if (CGRectIntersectsRect(self.view.frame, rect)) {
//        NSLog(@"true");
//    }else{
//        NSLog(@"false");
//    }
    NSLog(@"rect :%f",rect.origin.y);
    return rect.origin.y;
}
+(void)setPercentGrayview:(UIView*)grayView redView:(UIView*)redView percent:(NSInteger)percent
{
    [redView setFrame:CGRectMake(PARENT_X(redView), PARENT_Y(redView), grayView.frame.size.width*((float)percent>100?100:(float)percent)/100.0, PARENT_HEIGHT(redView))];
}
//judge wheather is pure number
+(BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:
              [NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}
@end
