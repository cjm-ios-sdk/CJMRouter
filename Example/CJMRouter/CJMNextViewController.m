//
//  CJMNextViewController.m
//  CJMRouter_Example
//
//  Created by chenjm on 2020/4/9.
//  Copyright © 2020 chenjm. All rights reserved.
//

#import "CJMNextViewController.h"
#import <CJMRouter/CJMRouter.h>
#import "CJMAppDelegate.h"
#import "CJMLoginViewController.h"

@interface CJMNextViewController ()

@end

@implementation CJMNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.title = @"下一页";
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pressedNext:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"点击登录" forState:UIControlStateNormal];
    button.center = self.view.center;
}

- (void)pressedNext:(UIButton *)sender {
    CJMLoginViewController *viewController = [[CJMLoginViewController alloc] init];
    UINavigationController *navigationController = [[CJMAppDelegate shareInstance] navigationControllerWithRootViewController:viewController];
    navigationController.view.backgroundColor = [UIColor grayColor];
    [self.navigationController presentViewController:navigationController animated:YES completion:^{
        
    }];
}


@end
