//
//  SuggestVC.m
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SuggestVC.h"
#import "SuggestTopCell.h"
#import "SuggestBottomCell.h"
#import "SelectCell.h"
@interface SuggestVC ()

@end

@implementation SuggestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"意见反馈";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryItems=[NSMutableArray arrayWithObjects:@"页面展示",@"理财",@"众筹",@"充值",@"提现",@"其他", nil];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        SuggestTopCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"SuggestTopCell" owner:nil options:nil] objectAtIndex:0];
        return cell;
    }
    else if (indexPath.row>0&&indexPath.row<7)
    {
        SelectCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"SelectCell" owner:nil options:nil] objectAtIndex:0];
        cell.labelTitle.text=[self.m_aryItems objectAtIndex:indexPath.row-1];
        return cell;
    }

    else
    {
        SuggestBottomCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"SuggestBottomCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (indexPath.row==0)
    {
        height=35;
    }
    else if (indexPath.row>0&&indexPath.row<7)
    {
        height=40;
    }
    
    else
    {
        height=230;
    }

    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>0&&indexPath.row<7)
    {
        SelectCell *cell=(SelectCell*)[tableView cellForRowAtIndexPath:indexPath];
        if ([cell.selectImg.image isEqual:[UIImage imageNamed:@"circle"]])
        {
            [cell.selectImg setImage:[UIImage imageNamed:@"gou_in_circle"]];
        }
        else
        {
            [cell.selectImg setImage:[UIImage imageNamed:@"circle"]];
        }
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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