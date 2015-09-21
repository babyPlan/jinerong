//
//  RechargeWebVC.m
//  jinerong
//
//  Created by carcool on 6/17/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "RechargeWebVC.h"
#import "RechargeVC.h"
#import "PaySuccessForLicaiVC.h"
#import "PaySuccessForZhongchouVC.h"

@interface RechargeWebVC ()

@end

@implementation RechargeWebVC
@synthesize webView,dic,oldRequest,isAuthed,m_recgargeVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isAuthed=NO;
    self.title=@"充值";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
//    [self updateView];
}
-(void)updateView
{
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.view addSubview:self.webView];
//    webView.scrollView.bounces=NO;
//    webView.scalesPageToFit =YES;
    webView.delegate =self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ldys_pre_form" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}
#pragma mark ----- connnection delegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
//    if([challenge.protectionSpace.host isEqualToString:@"114.113.159.203"] /*check if this is host you trust: */ )
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    self.isAuthed=YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //webview 重新加载请求。
    [webView loadRequest:self.oldRequest];
    [connection cancel];
}
#pragma mark ----- webdelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad :%@",self.webView.request.mainDocumentURL.relativePath);
    if ([self.webView.request.mainDocumentURL.relativePath rangeOfString:@"ldys_pre_form.html"].location!=NSNotFound)//local html
    {
        [self submitForm];

    }
    //    else if ([self.webView.request.mainDocumentURL.relativePath rangeOfString:@"invest/mobile/ldysReturnUrl.action"].location!=NSNotFound)//return recharge result
//    {
//        NSLog(@"self.webView.request3 :%@",self.webView.request);
//    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* scheme = [[request URL] scheme];
    NSLog(@"scheme = %@",scheme);
    //判断是不是https
    if ([scheme isEqualToString:@"https"]&&self.isAuthed==NO)
    {
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
            NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [conn start];
        self.oldRequest=request;
            [self.webView stopLoading];
            return NO;
    }
    
    NSLog(@"request.mainDocumentURL.relativePath :%@",request.mainDocumentURL.relativePath);
    //recharge return success.
    if ([request.mainDocumentURL.relativePath rangeOfString:@"spay/pay/p2pProjectTransfer.do"].location!=NSNotFound)
    {
        NSLog(@"my_request:%@",[request.URL absoluteString]);
        if ([[request.URL absoluteString] rangeOfString:@"https://pay.soopay.net/spay/f.jsp"].location!=NSNotFound) {
            if ([self.typeIndex isEqualToString:@"0"] ) {//0:zhongchou 1:licai 3:chongzhi
            
            PaySuccessForZhongchouVC* vc= [[PaySuccessForZhongchouVC alloc]init];
            vc.data=(NSMutableDictionary*)self.data;
            for (NSString *key in [self.zhongchouSuccessData allKeys])
            {
                [vc.data setObject:[self.zhongchouSuccessData objectForKey:key] forKey:key];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }else if([self.typeIndex isEqualToString:@"1"]){
            
            PaySuccessForZhongchouVC* vc=[[PaySuccessForZhongchouVC alloc]init];
            vc.data=(NSMutableDictionary*)self.data;
            for (NSString *key in [self.licaiSuccessData allKeys])
            {
                [vc.data setObject:[self.licaiSuccessData objectForKey:key] forKey:key];
            }

            [self.navigationController pushViewController:vc animated:YES];
        }
        }
    }
    if ([request.mainDocumentURL.relativePath rangeOfString:@"invest/mobile/ldysReturnUrl.action"].location!=NSNotFound)
    {
        NSLog(@"request:%@",[request.URL absoluteString]);
        if ([[request.URL absoluteString] rangeOfString:@"ret_code="].location!=NSNotFound)
        {
            NSInteger index=[[request.URL absoluteString] rangeOfString:@"ret_code="].location+9;
            NSString *ret_codeValue=[[request.URL absoluteString] substringWithRange:NSMakeRange(index, 4)];
            NSLog(@"ret_codeValue :%@",ret_codeValue);
            
            if ([ret_codeValue isEqualToString:@"0000"])
            {
                NSLog(@"recharge success!!");
                NSLog(@"self.webView.request2 :%@",self.webView.request);
                
               if([self.typeIndex isEqualToString:@"3"]){
                    
                    [self showMessage:@"充值成功"];
                   [self.navigationController popViewControllerAnimated:YES];
                }
                
            }
            else
            {
                [self showMessage:@"支付失败"];
            }
        }
       
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getTitle {
    
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showAlert(\"%@\");",@"oop"]];
}
-(void)submitForm
{
    NSDictionary *field=[[self.dic objectForKey:@"reqData"] objectForKey:@"field"];
    NSMutableString *html=[NSMutableString stringWithString:@""];
    for (NSString *mykey in [field allKeys])
    {
        [html appendFormat:@"%s%@%s%@%s","<input type='hide' name='",mykey,"' value='",[field objectForKey:mykey],"'/>"];
    }
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"submitHtml(\"%@\",\"%@\");",[[self.dic objectForKey:@"reqData"]  objectForKey:@"url"],html]];
    
}
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
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
