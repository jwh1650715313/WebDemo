//
//  ViewController.m
//  WebDemo
//
//  Created by JIng on 2017/7/18.
//  Copyright © 2017年 JIng. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:nil];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"web_test" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    [self.bridge registerHandler:@"ocFunc1" handler:^(id data, WVJBResponseCallback responseCallback) {
        self.label.text = [NSString stringWithFormat:@"来自JS的消息：%@", data];
        responseCallback(@"我是OC");
    }];
}



- (IBAction)btnClick:(id)sender {
    
    
     [self.bridge callHandler:@"jsFunc1" data:@"我是OC按钮触发"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
