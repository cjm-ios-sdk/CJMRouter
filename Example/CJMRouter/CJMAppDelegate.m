//
//  CJMAppDelegate.m
//  CJMRouter
//
//  Created by chenjm on 04/08/2020.
//  Copyright (c) 2020 chenjm. All rights reserved.
//

#import "CJMAppDelegate.h"
#import "CJMViewController.h"
#import <CJMRouter/CJMRouter.h>

@interface CJMAppDelegate () <UINavigationController_CJMRouterDelegate>

@end

static id _shareInstance = nil;

@implementation CJMAppDelegate

+ (instancetype)shareInstance {
    return _shareInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _shareInstance = self;
    
    CJMViewController *viewController = [[CJMViewController alloc] init];
    UINavigationController *navigationController = [self navigationControllerWithRootViewController:viewController];
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    navigationController.cjmr_routerDelegate = self;
    return navigationController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - UINavigationController_CJMRouterDelegate

- (UIViewController *)navigationController:(UINavigationController *)navigationController routerRequest:(CJMRouterRequest *)routerRequest {
    NSLog(@"navigationController=%@", navigationController);
    
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
            CJMRouterErrorViewController *evc = [CJMRouterErrorViewController new];
            evc.cjmr_paramters = routerRequest.allParamters;
            return evc;
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

@end
