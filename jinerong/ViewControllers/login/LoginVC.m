//
//  LoginVC.m
//  jinerong
//
//  Created by carcool on 6/3/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPasswordVC.h"
#import "OpenAgreementWebVC.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"登录";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(dismissMyself) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"注册"];
    [self.rightNaviBtn addTarget:self action:@selector(showRegisterVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnLogin setColor:JER_RED];
    [self.btnQQLogin setColor:JER_BLUE];
    [MyFounctions setLineViewMoreThin:self.lineView0];
    [self.lineView0 setBackgroundColor:JER_BG_GRAY];
    self.textField0.delegate=self;
    self.textField1.delegate=self;
    [self.textField1 setSecureTextEntry:YES];
    self.originalHeight_superView=self.view.frame.origin.y;
}
- (UIImage*) imageWithUIView:(UIView*) view{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateLogin
{
    NSMutableDictionary *paras_fource = [[NSMutableDictionary alloc]initWithCapacity:10];
    [paras_fource setObject:SH_LOGIN forKey:SH_LINK];
    [paras_fource setObject:self.textField0.text forKey:@"name"];
    [paras_fource setObject:[SHAPI md5:self.textField1.text] forKey:@"password"];
    self.SHRequest_ = [SHAPI requestWithParas:paras_fource];
    [self.SHRequest_ setDelegate:self];
    self.currentRequest=SH_LOGIN;
    [self.SHRequest_ startAsynchronous];
}
#pragma mark ======== request delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary * item = (NSDictionary *)[responseString JSONValue];
    NSLog(@"........%@",item);
    if ([[item objectForKey:@"result"] isEqualToString:@"0"])
    {
        if ([self.currentRequest isEqualToString:SH_LOGIN])//adver pictures
        {
            [MyFounctions saveUserInfo:item];
            [self dismissMyself];
            //user
//            avatarUrl = "<null>";
//            isRealName = 1;
//            mobileNo = 18523877818;
//            nickName = "";
//            realName = "\U79e6\U4e91";
//            reqData =     {
//                field =         {
//                    "account_id" = 02000000052106;
//                    charset = "UTF-8";
//                    "mer_id" = 7050129;
//                    "notify_url" = "http://123.57.32.236/invest/notify/notifyReq.action";
//                    "res_format" = HTML;
//                    "ret_url" = "http://123.57.32.236/invest/user/bindAgreementReturn.action";
//                    service = "mer_bind_agreement";
//                    sign = "SJxG9wpdHiUs534wO7mDR2ZKSYJomHdkpuwyuxstRk+Vjwtmsos3/oUPmJvhor6rfMDrxHZhB1nMe1qoTHPI/yDQR4wFEIXivQXesPwbkuV303h4diufXNZJbYb1Jr+7ds1SOpPB+7heKqm1HuCmYMS8DxzdHuVpeOAuJaqJ8xQ=";
//                    "sign_type" = RSA;
//                    sourceV = HTML5;
//                    "user_bind_agreement_list" = ZTBB0G00;
//                    "user_id" = UB201506231706350000000000019931;
//                    version = "1.0";
//                };
//                plain = "account_id=02000000052106&charset=UTF-8&mer_id=7050129&notify_url=http%3A%2F%2F123.57.32.236%2Finvest%2Fnotify%2FnotifyReq.action&res_format=HTML&ret_url=http%3A%2F%2F123.57.32.236%2Finvest%2Fuser%2FbindAgreementReturn.action&service=mer_bind_agreement&sign_type=RSA&sourceV=HTML5&user_bind_agreement_list=ZTBB0G00&user_id=UB201506231706350000000000019931&version=1.0";
//                sign = "SJxG9wpdHiUs534wO7mDR2ZKSYJomHdkpuwyuxstRk+Vjwtmsos3/oUPmJvhor6rfMDrxHZhB1nMe1qoTHPI/yDQR4wFEIXivQXesPwbkuV303h4diufXNZJbYb1Jr+7ds1SOpPB+7heKqm1HuCmYMS8DxzdHuVpeOAuJaqJ8xQ=";
//                url = "http://114.113.159.203:9200/spay/pay/payservice.do";
//            };
//            result = 0001;
//            tip = "\U6210\U529f";
//            uid = 3163;
        }
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"0001"])
    {
        [MyFounctions saveUserInfo:item];//login success
        OpenAgreementWebVC *vc=[[OpenAgreementWebVC alloc] init];
        vc.delegate=self;
        vc.dic=item;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([[item objectForKey:@"result"] isEqualToString:@"1"])
    {
        NSString *alertString = [item objectForKey:@"tip"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertString message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark ------ textfield delaget
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(PARENT_X(self.view),64, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];

    float textfiled_y=[textField convertRect:self.textFieldBG.frame toView:self.view].origin.y;
    if (textfiled_y>Screen_Height-KEYBOARD_HEIGHT)
    {
        float _y=Screen_Height-KEYBOARD_HEIGHT-textfiled_y;
        [self.view setFrame:CGRectMake(PARENT_X(self.view),PARENT_Y(self.view)+_y , PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view setFrame:CGRectMake(PARENT_X(self.view),64, PARENT_WIDTH(self.view), PARENT_HEIGHT(self.view))];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------event response
-(void)dismissMyself
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)showRegisterVC
{
    RegisterVC *vc=[[RegisterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)LoginBtnPressed:(id)sender
{
    [self updateLogin];
}
-(IBAction)forgetPassword:(id)sender
{
    ForgetPasswordVC *vc=[[ForgetPasswordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
