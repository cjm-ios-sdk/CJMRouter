# CJMRouter

[![CI Status](https://img.shields.io/travis/chenjm/CJMRouter.svg?style=flat)](https://travis-ci.org/chenjm/CJMRouter)
[![Version](https://img.shields.io/cocoapods/v/CJMRouter.svg?style=flat)](https://cocoapods.org/pods/CJMRouter)
[![License](https://img.shields.io/cocoapods/l/CJMRouter.svg?style=flat)](https://cocoapods.org/pods/CJMRouter)
[![Platform](https://img.shields.io/cocoapods/p/CJMRouter.svg?style=flat)](https://cocoapods.org/pods/CJMRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

该路由器主要是通过扩展UINavigationController来实现了路由功能。之所以使用导航控制器来实现，是因为导航有路由的意思，直接使用导航控制器可以更加方便移植和使用。

### 使用

- 初始化，设置代理功能

```objc
UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
navigationController.cjmr_routerDelegate = self;
```

- 实现代理方法，处理不同请求。其中`CJMRouterRequest`是解析url得到各参数的请求对象；`CJMRouterTable`是由框架定义的默认路由表（用户也可自行定义）；`CJMRouterErrorViewController`是用于提示错误的默认视图控制器（用户可自行定义）；`CJMRouterWebViewController`是内部默认网页视图控制器（用户可自行定义）。

```objc
- (UIViewController *)navigationController:(UINavigationController *)navigationController routerRequest:(CJMRouterRequest *)routerRequest {
    if (!routerRequest.urlString) {
        return [CJMRouterErrorViewController new];
    }
        
    if (routerRequest.isHttp) {
        CJMRouterWebViewController *webVC = [[CJMRouterWebViewController alloc] init];
        webVC.url = [NSURL URLWithString:routerRequest.urlString];
        return webVC;
    }

    if (!routerRequest.urlScheme || ![routerRequest.urlScheme isEqualToString:@"app_scheme"]) {
        return [CJMRouterErrorViewController new];
    }

    NSString *path = [[NSBundle mainBundle] pathForResource:@"router" ofType:@"plist"];
    NSDictionary *list = [[NSDictionary alloc] initWithContentsOfFile:path];
    CJMRouterTable *routerTable = [[CJMRouterTable alloc] initWithPageIdList:list];
    
    NSString *openType = routerRequest.allParamters[@"open_type"];
    if (openType && [openType isEqualToString:@"native_page"]) {
        // 原生页面
        NSString *pageId = routerRequest.allParamters[@"page_id"];
        UIViewController *vc = [routerTable viewControllerByPageId:pageId];
        if (vc && [vc isKindOfClass:[UIViewController class]]) {
            vc.cjmr_paramters = routerRequest.allParamters;
            return vc;
        } else {
            return [CJMRouterErrorViewController new];
        }
    } else if (openType && [openType isEqualToString:@"web_page"]) {
        // 网页
        CJMRouterWebViewController *webVC = [[CJMRouterWebViewController alloc] init];
        webVC.url = [NSURL URLWithString:routerRequest.urlString];
        return webVC;
    } else if (openType && [openType isEqualToString:@"external_page"]) {
        // 外部网页
        NSString *url = routerRequest.allParamters[@"url"];
        [navigationController cjmr_openUrlString:url completion:^(BOOL flag) {
            NSLog(@"open url %@ %@!", url, flag ? @"success" : @"failed");
        }];
        return nil;
    } else {
        return nil;
    }
    return nil;
}
```

- 推入视图控制器

```objc
NSString *url = @"app_scheme://goto?open_type=native_page&page_id=100002";
[self.navigationController cjmr_pushViewControllerWithUrlString:url paramters:nil animated:YES];
```
- 推出视图控制器

```objc
// 推出到当前视图控制器，其他的可参考UINavigationController的接口
[self.navigationController popViewControllerAnimated:YES];
```

- present 一个新的导航控制器，拥有一个新的路由控制器

```objc
CJMLoginViewController *viewController = [[CJMLoginViewController alloc] init];
UINavigationController *navigationController = [CJMAppDelegate navigationControllerWithRootViewController:viewController];
navigationController.view.backgroundColor = [UIColor grayColor];
[self.navigationController presentViewController:navigationController animated:YES completion:^{
    
}];
```

## Version

- 0.1.1 修复presetViewController的bug



## Requirements

## Installation

CJMRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CJMRouter'
```

## Push

```shell
pod trunk push CJMRouter.podspec --allow-warnings
```

## Author

chenjm, cjiemin@163.com

## License

CJMRouter is available under the MIT license. See the LICENSE file for more info.
