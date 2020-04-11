//
//  CJMViewController.m
//  CJMRouter
//
//  Created by chenjm on 04/08/2020.
//  Copyright (c) 2020 chenjm. All rights reserved.
//

#import "CJMViewController.h"
#import <CJMRouter/CJMRouter.h>

@interface CJMViewController ()
@end

@implementation CJMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"root 页面";
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *url = @"app_scheme://goto?open_type=native_page&page_id=100001";
    [self.navigationController cjmr_pushViewControllerWithUrlString:url paramters:nil animated:YES];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
