//
//  JERViewController.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHAPI.h"
#import "SDRefresh.h"
@interface JERViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)UIImageView *bg;
@property(retain,nonatomic)UIButton *leftNaviBtn;
@property(retain,nonatomic)UIButton *rightNaviBtn;
@property(nonatomic,retain)UIImageView *redPointImg;
@property(retain,nonatomic)UITableView *m_tableView;
@property(nonatomic,retain)UIView *blackBG;
@property(nonatomic,retain)UIAlertView *alertView;
@property(nonatomic,retain)UIActivityIndicatorView *m_activitiIndicatorView;
@property(nonatomic,retain)UIView *m_MessageBG;
@property(nonatomic,retain)SHAPI * SHRequest_;
@property(nonatomic,retain)NSString *currentRequest;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger pageCount;
@property (nonatomic, assign) NSInteger totalRowCount;
//refresh more for tableview
@property (nonatomic, retain) SDRefreshFooterView *refreshFooter;
@property (nonatomic, retain) SDRefreshHeaderView *refreshHeader;
#pragma mark ---navigation settings
-(void)setLeftNaviBtnImage:(UIImage *)img;
-(void)setRightNaviBtnImage:(UIImage *)img;
-(void)addRedPointImgOnRightBtn;
-(void)setLeftNaviBtnTitle:(NSString *)str;
-(void)setRightNaviBtnTitle:(NSString *)str;
//-(void)setRightNaviBtnForHomeImage:(UIImage *)img;
//-(void)setRightNaviBtnImage:(UIImage *)img title:(NSString*)title;
-(void)popSelfViewContriller;
#pragma mark ------tableview
-(void)addTableView;
-(void)addTableViewWithStyle:(UITableViewStyle)style;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark --------- refresh
- (void)setupHeader;
- (void)setupFooter;
-(void)headerRefresh;
- (void)footerRefresh;
#pragma mark -------- alert view
-(void)showAlertViewWithTitle:(NSString*)title message:(NSString*)msg cancelButton:(NSString*)cancel others:(NSString*)others;
//load
-(void)showLoadingWithBG;
-(void)stopLoadingWithBG;
-(void)startLoading;
-(void)startLoadingGray;
-(void)startLoadingWithMyMessage:(NSString*)message;
-(void)startLoadingWithMyMessageOnWindow:(NSString *)message;
-(void)stopLoading;
-(void)stopLoadingWithMyMessage;
-(void)showMessage:(NSString*)str;
-(void)showMessage:(NSString *)str seconds:(float)seconds;
//add black bg
-(void)addBlackBGView;
-(void)addBlackBGViewOnKeywindow;
-(void)removeBLackBGView;
#pragma mark -------network is not connected
-(void)showNetworkError;
//set line view thin
-(void)setLineViewMoreThin:(UIView*)line;
@end

