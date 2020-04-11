//
//  UINavigationController+CJMRouter.m
//  CJMRouter
//
//  Created by chenjm on 2020/4/10.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import "UINavigationController+CJMRouter.h"
#import <objc/runtime.h>
#import <StoreKit/StoreKit.h>

@implementation UINavigationController (CJMRouter)

- (id)cjmr_routerDelegate {
    return objc_getAssociatedObject(self, @selector(cjmr_routerDelegate));
}

- (void)setCjmr_routerDelegate:(id)cjmr_routerDelegate {
    objc_setAssociatedObject(self, @selector(cjmr_routerDelegate), cjmr_routerDelegate, OBJC_ASSOCIATION_ASSIGN);
}

/**
 * @brief 推入视图控制器
 * @param urlString urlEncode的字符串，+号转为空格号。
 * @param paramters 如果是内部页面，可以传入viewController的参数
 * @param animated 动画
 */
- (void)cjmr_pushViewControllerWithUrlString:(NSString *)urlString
                                   paramters:(NSDictionary *)paramters
                                    animated:(BOOL)animated {
    CJMRouterRequest *routerRequest = [[CJMRouterRequest alloc] initWithUrlString:urlString paramters:paramters];
    if (self.cjmr_routerDelegate) {
        UIViewController *vc = [self.cjmr_routerDelegate navigationController:self routerRequest:routerRequest];
        if (vc) {
            [self pushViewController:vc animated:animated];
        }
    }
}

/**
 * @brief 展示视图控制器
 * @param completion 关闭完成
 */
- (void)cjmr_presentViewControllerWithUrlString:(NSString *)urlString
                                      paramters:(NSDictionary *)paramters
                                       animated:(BOOL)animated
                                     completion:(void (^)(void))completion {
    CJMRouterRequest *routerRequest = [[CJMRouterRequest alloc] initWithUrlString:urlString paramters:paramters];
    if (self.cjmr_routerDelegate) {
        UIViewController *vc = [self.cjmr_routerDelegate navigationController:self routerRequest:routerRequest];
        if (vc) {
            [self pushViewController:vc animated:animated];
        }
    }
}

- (void)cjmr_dismissViewControllerWithAnimated:(BOOL)animated
                                    completion:(void (^)(void))completion {
    [self.navigationController dismissViewControllerAnimated:animated completion:completion];
}

- (void)cjmr_openUrlString:(NSString *)urlString
                completion:(void (^)(BOOL))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [app openURL:url options:@{} completionHandler:completion];
        } else {
            BOOL flag = [app openURL:url];
            if (completion) {
                completion(flag);
            }
        }
    } else {
        if (completion) {
            completion(NO);
        }
    }
}

@end
