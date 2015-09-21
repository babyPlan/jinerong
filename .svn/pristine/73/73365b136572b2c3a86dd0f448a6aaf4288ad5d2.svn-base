//
//  SHAPI.m
//  jinrongSohu
//
//  Created by luc on 14-4-9.
//  Copyright (c) 2014年 Shang. All rights reserved.
//

#import "SHAPI.h"
#import <CommonCrypto/CommonDigest.h>

@implementation SHAPI
@synthesize patas = paras_;

-(id) initWithParas:(NSMutableDictionary*) paras
{
    
    if (self)
    {
        self.patas = paras;
        self.requestMethod = @"POST";
        self.timeOutSeconds = 60;
        self.stringEncoding = NSUTF8StringEncoding;
        NSString * str_link = [self.patas objectForKey:SH_LINK];
        NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"%@%@",HOSTSERVER,str_link];
        NSMutableString * str_log = [[NSMutableString alloc]init];
        int i = 0;
        for (NSString * key in [self.patas allKeys])
        {
            if (i == 0 && self.patas.count > 1) {
                [str_log appendString:@"?"];
            }
            if (![key isEqualToString:SH_LINK])
            {
              [self setPostValue:[paras_ objectForKey:key] forKey:key];
                [str_log appendFormat:@"%@=%@",key,[paras_ objectForKey:key]];
            }
            if (i < self.patas.count - 1) {
                [str_log appendString:@"&"];
            }
            i++;
        }
        NSURL *_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",str]];
        [self setDidFinishSelector:@selector(requestFinished:)];
        [self setDidFailSelector:@selector(requestFailed:)];
        self = [super initWithURL:_url];
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@",str,str_log]);
    }
    return self;
}

+(id) requestWithParas:(NSMutableDictionary*) paras
{
	return [[self alloc] initWithParas:paras];
}


//MD5加密
+ (NSString *)md5:(NSString *)str

{
    
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
    
}

@end
