//
//  RechargeWebVC.h
//  jinerong
//
//  Created by carcool on 6/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"
@class RechargeVC;
@interface RechargeWebVC : JERViewController<UIWebViewDelegate,NSURLConnectionDelegate>
@property(nonatomic,retain)NSMutableDictionary *dic;
@property(nonatomic,retain)UIWebView *webView;
@property(nonatomic,retain)NSURLRequest* oldRequest;
@property(nonatomic,assign)BOOL isAuthed;
@property(nonatomic,retain)NSString* typeIndex;
@property(nonatomic,retain)RechargeVC *m_recgargeVC;
@property(nonatomic,retain)NSDictionary* data;
@property(nonatomic,retain)NSDictionary *zhongchouSuccessData;
@property(nonatomic,retain)NSDictionary* licaiSuccessData;
-(void)updateView;
@end
