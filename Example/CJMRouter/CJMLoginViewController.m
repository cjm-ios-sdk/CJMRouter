//
//  CJMLoginViewController.m
//  CJMRouter_Example
//
//  Created by chenjm on 2020/4/11.
//  Copyright © 2020 chenjm. All rights reserved.
//

#import "CJMLoginViewController.h"
#import <CJMRouter/CJMRouter.h>

@interface CJMLoginViewController ()

@end

@implementation CJMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"登录页";
    
    UIButton *button0 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:button0];
    [button0 addTarget:self action:@selector(pressedWebView:) forControlEvents:UIControlEventTouchUpInside];
    [button0 setTitle:@"点击跳转到网页" forState:UIControlStateNormal];
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pressedNext:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点击跳转到下一页" forState:UIControlStateNormal];
    button.center = self.view.center;
}

- (void)pressedNext:(UIButton *)sender {
    NSString *url = @"app_scheme://goto?open_type=native_page&page_id=100002";
    [self.navigationController cjmr_pushViewControllerWithUrlString:url paramters:nil animated:YES];
}

- (void)pressedWebView:(UIButton *)sender {
    NSString *url = @"https://www.baidu.com";
    [self.navigationController cjmr_pushViewControllerWithUrlString:url paramters:nil animated:YES];
}

@end
