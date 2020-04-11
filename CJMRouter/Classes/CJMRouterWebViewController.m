//
//  CJMRouterWebViewController.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/8.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import "CJMRouterWebViewController.h"

@interface CJMRouterWebViewController () <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) WKProcessPool *processPool;//单例使用


@end

@implementation CJMRouterWebViewController
@synthesize webView = _webView;

#pragma mark - 重写父类方法

- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationBarColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    _processPool = ({
        static WKProcessPool *pool = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            pool = [[WKProcessPool alloc] init];
        });
        pool;
    });
     
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.processPool = _processPool;
    configuration.allowsInlineMediaPlayback = YES;
    if (@available(iOS 9.0, *)) {
        configuration.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    }
    
    if (@available(iOS 10.0, *)) {
        [configuration setValue:@YES forKey:@"allowUniversalAccessFromFileURLs"];
    }

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];

    //应用于 ajax 请求的 cookie 设置
    NSString *cookieSource = [NSString stringWithFormat:@"document.cookie = 'user=%@';", @"userValue"];
    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:cookieSource injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:cookieScript];
    configuration.userContentController = userContentController;

    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    [self loadWithUrl:_url];
}

- (void)loadWithUrl:(NSURL *)url {
    if (!url || !_webView) {
        return;
    }
    NSURLRequest *webRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                            timeoutInterval:30];
    [self.webView loadRequest:webRequest];
}

- (void)setUrl:(NSURL *)url {
    _url = url;
    
    [self loadWithUrl:url];
}


- (void)setCookie:(NSArray *)cookies {
    if (cookies.count > 0) {
        for (NSHTTPCookie *cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}

#pragma mark - 存取


- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    _navigationBarColor = navigationBarColor;
}

- (void)setWebBackgroundColor:(UIColor *)webBackgroundColor {
    _webBackgroundColor = webBackgroundColor;
    
    self.webView.scrollView.backgroundColor = webBackgroundColor;
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}


#pragma mark - WKUIDelegate

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (navigationAction.request.URL) {
        
    }
    return nil;
}


#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if (@available(iOS 12.0, *)) {//iOS11也有这种获取方式，但是我使用的时候iOS11系统可以在response里面直接获取到，只有iOS12获取不到
            WKHTTPCookieStore *cookieStore = webView.configuration.websiteDataStore.httpCookieStore;
            [cookieStore getAllCookies:^(NSArray* cookies) {
                [self setCookie:cookies];
            }];
        }else {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
            NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
            [self setCookie:cookies];
        }
    decisionHandler(WKNavigationResponsePolicyAllow);
}


- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{

}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
     //新版本的H5拦截支付对老版本的获取订单串和订单支付接口进行合并，推荐使用该接口
    decisionHandler(actionPolicy);
}

@end
