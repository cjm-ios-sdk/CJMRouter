//
//  CJMRouterWebViewController.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/8.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface CJMRouterWebViewController : UIViewController

@property (nonatomic, strong) UIColor *_Nullable navigationBarColor;  // 导航栏颜色
@property (nonatomic, strong, readonly) WKWebView *_Nullable webView;
@property (nonatomic, strong) UIColor *_Nullable webBackgroundColor;  // webView背景色
@property (nonatomic, copy) NSURL *_Nullable url;

@end
