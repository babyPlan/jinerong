//
//  HomeVC.m
//  jinerong
//
//  Created by carcool on 5/25/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeVC.h"
#import "HomeLicaiCell0.h"
#import "HomeLicaiCell1.h"
#import "HomeYZCCell0.h"
#import "LicaiDetailVC.h"
#import "ZhongchouDetailVC.h"
#import "ConfirmLicaiVC.h"
#import "AppDelegate.h"
#import "myTabbarVC.h"
#import "LicaiFiltrateVC.h"
#import "HomeFiltrateCell.h"
@interface HomeVC ()

@end

@implementation HomeVC
@synthesize m_showedDatas,indexFlag,m_aryDatas,m_aryAdvers,scrollViewGuid,pageControl,m_guideBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"首页";
    self.navigationController.navigationBarHidden=YES;
    self.indexFlag=0;
    
//    [self creatPageScrollview];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 175, Screen_Width, Screen_Height-175-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
    [self setupHeader];
    [self setupFooter];
    
    if(self.indexFlag==0)
    {
        [self.btnYlc setTitleColor:JER_RED forState:UIControlStateNormal];
        [self.btnYzc setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.m_showedDatas=[NSMutableArray array];
    }
    else
    {
        [self.btnYlc setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnYzc setTitleColor:JER_RED forState:UIControlStateNormal];
         self.m_showedDatas=[NSMutableArray arrayWithObjects:@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0",@"yzccell0", nil];
    }
    self.m_aryDatas=[NSMutableArray array];
    self.m_dicInput=[NSMutableDictionary dictionary];
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    //guide new
    if (![[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/Myguide",[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) objectAtIndex: 0]]])
    {
        [self showNewGuidViews];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
}
-(void)showNewGuidViews
{
    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.scrollViewGuid=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.scrollViewGuid.bounces=NO;
    self.scrollViewGuid.delegate=self;
    self.scrollViewGuid.tag=11;
    [scrollViewGuid setContentSize:CGSizeMake(Screen_Width, Screen_Height)];
    scrollViewGuid.showsHorizontalScrollIndicator=NO;
    scrollViewGuid.pagingEnabled=YES;
    [scrollViewGuid setBackgroundColor:[UIColor whiteColor]];
    [delegate.window addSubview:self.scrollViewGuid];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Screen_Height-30, Screen_Width, 20)];
    [pageControl setBackgroundColor:[UIColor clearColor]];
    pageControl.currentPage = 0;
    pageControl.hidesForSinglePage=YES;
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.numberOfPages = 4;
    [delegate.window addSubview:pageControl];
    
    [self.scrollViewGuid setContentSize:CGSizeMake(Screen_Width*4, Screen_Height)];
    NSInteger i=0;
    while (i<4)
    {
        UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(i*Screen_Width, 0, PARENT_WIDTH(scrollViewGuid), PARENT_HEIGHT(scrollViewGuid))];
        image1.userInteractionEnabled=YES;
        [image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i5_%ld.jpg",i+1]]];
        if (Screen_Height<=480)
        {
            [image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"i4_%ld.jpg",i+1]]];
        }
        [scrollViewGuid addSubview:image1];
        i++;
        
        if (i==4)
        {
            self.m_guideBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.m_guideBtn setFrame:CGRectMake((Screen_Width-200)/2.0, Screen_Height-80, 200, 40)];
            if (Screen_Width<=480)
            {
                [self.m_guideBtn setFrame:CGRectMake((Screen_Width-177)/2.0, Screen_Height-80, 177, 35)];
            }
            [self.m_guideBtn setBackgroundImage:[UIImage imageNamed:@"guide_btn"] forState:UIControlStateNormal];
//            [self.m_guideBtn setBackgroundColor:[UIColor greenColor]];
            [self.m_guideBtn addTarget:self action:@selector(disappearGuideViews) forControlEvents:UIControlEventTouchUpInside];
            self.m_guideBtn.alpha=0.0;
            [image1 addSubview:self.m_guideBtn];
        }
    }

}
#pragma mark ======= scroll delegate
//UIScrollViewDelegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    if (sView.tag==11)
    {
        NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
        [pageControl setCurrentPage:index];
        if (index==3&&self.m_guideBtn.alpha!=1.0)
        {
            [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                self.m_guideBtn.alpha=1.0;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
-(void)disappearGuideViews
{
    self.navigationController.navigationBarHidden=NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.scrollViewGuid.alpha=0;
        } completion:^(BOOL finished) {
        [self.scrollViewGuid removeFromSuperview];
        self.scrollViewGuid=nil;
        [self.pageControl removeFromSuperview];
        self.pageControl=nil;
        //save  data
        NSData *mydata=[[NSData alloc] init];
        NSArray *array = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
        NSString *path = [NSString stringWithFormat:@"%@/Myguide",[array objectAtIndex: 0]];
        [mydata writeToFile:path atomically:NO];
    }];
}

-(void)creatPageScrollview
{
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:self.m_aryAdvers.count delegate:self];
    self.imagePlayerView.scrollInterval = 5.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    NSLog(@"index: %@",[self.m_aryAdvers objectAtIndex:index]);
    [[self.m_aryAdvers objectAtIndex:index] objectForKey:@"url"];
    [imageView setWebImageViewWithURL:[NSURL URLWithString:    [[self.m_aryAdvers objectAtIndex:index] objectForKey:@"url"]]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
}


-(void)viewDidLayoutSubviews
{
    [MyFounctions setLineViewMoreThin:self.linview0];
    [MyFounctions setLineViewMoreThin:self.linview1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_CAROUSELS forKey:SH_LINK];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_CAROUSELS;
    [self.SHRequest_ startAsynchronous];
}
-(void)updateLicaiData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_HOME forKey:SH_LINK];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_HOME;
    [self.SHRequest_ startAsynchronous];
}
-(void)updateZhongchouData
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_ZhongChouList forKey:SH_LINK];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
    [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_ZhongChouList;
    [self.SHRequest_ startAsynchronous];
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.refreshHeader endRefreshing];
    [self.refreshFooter endRefreshing];
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_CAROUSELS])//adver pictures
        {
            self.m_aryAdvers=[NSMutableArray arrayWithArray:[item objectForKey:@"list"]];
            [self creatPageScrollview];
            
            NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
            [paras_fource setObject:SH_HOME forKey:SH_LINK];
            [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageIndex] forKey:SH_PAGE_CURRENTPAGE];
            [paras_fource setObject:[NSString stringWithFormat:@"%ld",(long)self.pageCount] forKey:SH_PAGE_RECORDSPERPAGE];
            self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
            [self.SHRequest_ setDelegate:self];
            self.currentRequest=SH_HOME;
            [self.SHRequest_ startAsynchronous];
        }
        else if ([self.currentRequest isEqualToString:SH_HOME])//理财
        {
            NSArray *array=[item objectForKey:@"projects"];
            if (self.pageIndex==1)
            {
                [self.m_aryDatas removeAllObjects];
            }
            [self.m_aryDatas addObjectsFromArray:array];
            
            [self.m_showedDatas removeAllObjects];
            
            NSInteger i=0;
            while (i<self.m_aryDatas.count)
            {
                [self.m_showedDatas addObject:@"cell0"];
                i++;
            }
            [self.m_tableView reloadData];
            
        }
        else if ([self.currentRequest isEqualToString:SH_ZhongChouList])
        {
            NSArray *array=[item objectForKey:@"crowdFundings"];
            if (self.pageIndex==1)
            {
                [self.m_aryDatas removeAllObjects];
            }
            [self.m_aryDatas addObjectsFromArray:array];
            
            [self.m_showedDatas removeAllObjects];
            
            NSInteger i=0;
            while (i<self.m_aryDatas.count)
            {
                [self.m_showedDatas addObject:@"yzccell0"];
                i++;
            }
            [self.m_tableView reloadData];
        }
        
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)failWithError:(NSError *)theError
{
    NSLog(@"error :%@",theError);
}

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_showedDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        HomeLicaiCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeLicaiCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeLicaiCell0" owner:nil options:nil] objectAtIndex:0];
        }
        

        NSInteger i=0;
        NSInteger count=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_showedDatas objectAtIndex:i] isEqualToString:@"cell0"])
            {
                count++;
            }
            i++;
        }
        cell.data=[self.m_aryDatas objectAtIndex:count-1];
        [cell updateViews];
        return cell;
    }
    else if([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell1"])
    {
        HomeLicaiCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeLicaiCell1"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeLicaiCell1" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        //update data and view
        NSInteger i=0;
        NSInteger count=0;
        while (i<=indexPath.row)
        {
            if ([[self.m_showedDatas objectAtIndex:i] isEqualToString:@"cell0"])
            {
                count++;
            }
            i++;
        }
        cell.data=[self.m_aryDatas objectAtIndex:count-1];
        cell.index=count-1;
        [cell updateViews];
        
        return cell;

    }
    else
    {
        HomeYZCCell0 *cell=[tableView dequeueReusableCellWithIdentifier:@"HomeYZCCell0"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeYZCCell0" owner:nil options:nil] objectAtIndex:0];
        }
        cell.data=[self.m_aryDatas objectAtIndex:indexPath.row];
        [cell updateViews];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        height=130;
    }
    else if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"yzccell0"])
    {
        height=113;
    }
    else
    {
        height=90;
    }
    
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"cell0"])
    {
        if (indexPath.row+1<self.m_showedDatas.count&&[[self.m_showedDatas objectAtIndex:indexPath.row+1] isEqualToString:@"cell1"])//already expanded
        {
            HomeLicaiCell0 *cell=(HomeLicaiCell0*)[tableView cellForRowAtIndexPath:indexPath];
            [cell.arrowImg setImage:[UIImage imageNamed:@"arrow_down"]];
        }
        else//will expanded
        {
            HomeLicaiCell0 *cell=(HomeLicaiCell0*)[tableView cellForRowAtIndexPath:indexPath];
            [cell.arrowImg setImage:[UIImage imageNamed:@"arrow_up"]];
        }
        [self showDetail:indexPath.row];
    }
    else if ([[self.m_showedDatas objectAtIndex:indexPath.row] isEqualToString:@"yzccell0"])
    {
        ZhongchouDetailVC *vc=[[ZhongchouDetailVC alloc] init];
        vc.crowdFundingId=[[self.m_aryDatas objectAtIndex:indexPath.row] objectForKey:@"id"];
        [vc updateData];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (self.indexFlag==0)
//    {
//        return 30;
//    }
//    else
//    {
        return 0;
//    }
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (self.indexFlag==0)
//    {
//        UIView *sectionbg=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
//        [sectionbg setBackgroundColor:JER_BG_GRAY];
//        UILabel *labelFiltrate=[[UILabel alloc] initWithFrame:sectionbg.frame];
//        [labelFiltrate setText:@"筛选更多>"];
//        [labelFiltrate setTextAlignment:NSTextAlignmentRight];
//        [labelFiltrate setFont:[UIFont systemFontOfSize:13.0]];
//        [labelFiltrate setTextColor:[UIColor grayColor]];
//        [sectionbg addSubview:labelFiltrate];
//        
//        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setFrame:labelFiltrate.frame];
//        [btn addTarget:self action:@selector(showFiltrateVC) forControlEvents:UIControlEventTouchUpInside];
//        [sectionbg addSubview:btn];
//        return sectionbg;
//    }
//    else
//    {
//        return nil;
//    }
//}

-(void)headerRefresh
{
    self.pageIndex=1;
    if ([self.currentRequest isEqualToString:SH_HOME])
    {
        [self updateLicaiData];
    }
    else if ([self.currentRequest isEqualToString:SH_ZhongChouList])
    {
        [self updateZhongchouData];
    }
}
-(void)footerRefresh
{
    self.pageIndex++;
    if ([self.currentRequest isEqualToString:SH_HOME])
    {
        [self updateLicaiData];
    }
    else if ([self.currentRequest isEqualToString:SH_ZhongChouList])
    {
        [self updateZhongchouData];
    }
}

#pragma mark -------------- detail expand
-(void)showDetail:(NSInteger)index
{
    if (index+1<self.m_showedDatas.count&&[[self.m_showedDatas objectAtIndex:index+1] isEqualToString:@"cell1"])
    {
        [self hideDetail:index];
    }
    else
    {
        
        if (index<self.m_showedDatas.count-1)
        {
            [self.m_showedDatas insertObject:@"cell1" atIndex:index+1];
        }
        else
        {
            [self.m_showedDatas addObject:@"cell1"];
        }
        NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                     [NSIndexPath indexPathForRow:index+1 inSection:0],
                                     nil];
        [self.m_tableView beginUpdates];
        [self.m_tableView insertRowsAtIndexPaths:insertIndexPaths
                                withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.m_tableView endUpdates];
    }
    
}
-(void)hideDetail:(NSInteger)index
{
    
    [self.m_showedDatas removeObjectAtIndex:index+1];
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:
                                 [NSIndexPath indexPathForRow:index+1 inSection:0],
                                 nil];
    [self.m_tableView beginUpdates];
    [self.m_tableView deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.m_tableView endUpdates];
    
}
#pragma mark -------- event response
-(IBAction)menuBtnPressed:(id)sender
{
    self.pageIndex=1;
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        self.indexFlag=0;
        [self.btnYlc setTitleColor:JER_RED forState:UIControlStateNormal];
        [self.btnYzc setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self updateLicaiData];
    }
    else
    {
        self.indexFlag=1;
        [self.btnYlc setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnYzc setTitleColor:JER_RED forState:UIControlStateNormal];
        [self updateZhongchouData];
    }
}
-(void)showFiltrateVC
{
    LicaiFiltrateVC *vc=[[LicaiFiltrateVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showLicaiDetailVC:(NSString*)projNo
{
    LicaiDetailVC *vc=[[LicaiDetailVC alloc] init];
    vc.projNo=projNo;
    [vc updateData];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bidLicai:(NSString*)projNo
{
    if([[MyFounctions getUserInfo] objectForKey:@"mobileNo"])
    {
        ConfirmLicaiVC *vc=[[ConfirmLicaiVC alloc] init];
        vc.projNo=projNo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        LoginVC *vc=[[LoginVC alloc] init];
        [self presentViewController:[[JERNavigationController alloc] initWithRootViewController:vc] animated:YES completion:^{
            
        }];
    }
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
