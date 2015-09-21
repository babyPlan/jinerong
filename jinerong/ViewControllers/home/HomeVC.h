//
//  HomeVC.h
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JERViewController.h"

@interface HomeVC : JERViewController<ImagePlayerViewDelegate,UIScrollViewDelegate>
@property(nonatomic,retain)UIScrollView *scrollViewGuid;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UIButton *m_guideBtn;
@property(nonatomic,retain)NSMutableArray *m_showedDatas;
@property(nonatomic,retain)NSMutableDictionary *m_dicInput;
@property(nonatomic,retain)NSMutableArray *m_aryAdvers;
@property(nonatomic,assign)NSInteger indexFlag;
@property(nonatomic,retain)IBOutlet UIButton *btnYlc;
@property(nonatomic,retain)IBOutlet UIButton *btnYzc;
@property(nonatomic,retain)NSMutableArray *m_aryDatas;
@property(nonatomic,retain)IBOutlet UIView *linview0;
@property(nonatomic,retain)IBOutlet UIView *linview1;
@property (retain, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;
-(void)showLicaiDetailVC:(NSString*)projNo;
-(void)bidLicai:(NSString*)projNo;
@end
