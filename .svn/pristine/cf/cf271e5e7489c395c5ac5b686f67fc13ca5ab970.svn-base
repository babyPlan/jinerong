//
//  JiekuanConditionVC.m
//  jinerong
//
//  Created by carcool on 5/27/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "JiekuanConditionVC.h"

@interface JiekuanConditionVC ()

@end

@implementation JiekuanConditionVC
@synthesize m_aryMonths,pickerView,doneBtn,shieldView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"申请条件及必要资料";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryMonths=[NSMutableArray arrayWithObjects:@"3个月",@"4个月",@"5个月",@"6个月", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_aryMonths.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[self.m_aryMonths objectAtIndex:row];
    return str;
}
-(void)creatPickerView
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-200-49, Screen_Width, 30)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=0;
    
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-200-49-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor lightGrayColor]];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
//        self.shieldView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-PARENT_Y(doneBtn))];
//        [self.shieldView setBackgroundColor:[UIColor clearColor]];
//        [self.view addSubview:self.shieldView];
    
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    self.selectedMonth=index;
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    [self.shieldView removeFromSuperview];
    self.shieldView=nil;
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
