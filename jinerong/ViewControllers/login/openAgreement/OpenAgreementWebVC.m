//
//  OpenAgreementWebVC.m
//  jinerong
//
//  Created by carcool on 6/24/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OpenAgreementWebVC.h"
#import "LoginVC.h"
@interface OpenAgreementWebVC ()

@end

@implementation OpenAgreementWebVC
@synthesize dic,webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"联通优势";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popAllLoginVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateView];
}
-(void)popAllLoginVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.delegate dismissMyself];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateView
{
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-64-49)];
    [self.view addSubview:self.webView];
    webView.scrollView.bounces=NO;
    webView.scalesPageToFit =YES;
    webView.delegate =self;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ldys_pre_form" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
}
#pragma mark ----- webdelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"self.webView.request.mainDocumentURL.relativePath :%@",self.webView.request.mainDocumentURL.relativePath);
    if ([self.webView.request.mainDocumentURL.relativePath rangeOfString:@"ldys_pre_form.html"].location!=NSNotFound)
    {
        [self submitForm];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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
        //        html += "<input type='hide' name='"+item+"' value='"+data.reqData.field[item]+"'/>";
    }
    NSLog(@"html %@",html);
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"submitHtml(\"%@\",\"%@\");",[[self.dic objectForKey:@"reqData"]  objectForKey:@"url"],html]];
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
