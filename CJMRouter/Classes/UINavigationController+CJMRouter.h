//
//  UINavigationController+CJMRouter.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/10.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+CJMRouter.h"
#import "CJMRouterWebViewController.h"
#import "CJMRouterErrorViewController.h"
#import "UIViewController+CJMRouter.h"
#import "CJMRouterRequest.h"
#import "CJMRouterTable.h"

@protocol UINavigationController_CJMRouterDelegate <NSObject>
@required
- (UIViewController *_Nullable)navigationController:(UINavigationController *_Nonnull)navigationController routerRequest:(CJMRouterRequest *_Nonnull)routerRequest;

@end


@interface UINavigationController (CJMRouter)
@property (nonatomic, weak) id <UINavigationController_CJMRouterDelegate> _Nullable cjmr_routerDelegate;

/**
 * @brief 推入视图控制器
 * @param urlString urlEncode的字符串，+号转为空格号。
 * @param paramters 如果是内部页面，可以传入viewController的参数
 * @param animated 动画
 */
- (void)cjmr_pushViewControllerWithUrlString:(NSString *_Nonnull)urlString
                                   paramters:(NSDictionary *_Nullable)paramters
                                    animated:(BOOL)animated;
/**
 * @brief 展示视图控制器
 * @param completion 关闭完成
 */
- (void)cjmr_presentViewControllerWithUrlString:(NSString *_Nonnull)urlString
                                        paramters:(NSDictionary *_Nullable)paramters
                                        animated:(BOOL)animated
                                     completion:(void (^_Nullable)(void))completion;

- (void)cjmr_dismissViewControllerWithAnimated:(BOOL)animated
                                    completion:(void (^_Nullable)(void))completion;


- (void)cjmr_openUrlString:(NSString *_Nonnull)urlString
                completion:(void (^_Nullable)(BOOL))completion;


@end

