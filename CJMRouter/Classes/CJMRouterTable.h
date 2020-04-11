//
//  CJMRouterTable.h
//  CJMRouter
//
//  此路由表定义为三种元素，页面id，页面类名和页面名称。
//  为了方便查找pageId和pageClass，采用了两张表，一张以pageId为主键，另一张以pageClass为主键。
//
//  pageId为主键，如：
//  @{@"10000":@{@"page_class":@"CJMMainViewController", @"page_name":@"首页"}，
//    @"10001":@{@"page_class":@"CJMLoginViewController", @"page_name":@"登录页"}}
//
//  pageClass为主键，如：
//  @{@"CJMMainViewController":@{@"page_class":@"10000", @"page_name":@"首页"}，
//    @"CJMLoginViewController":@{@"page_class":@"10001", @"page_name":@"登录页"}}
//
//  Created by chenjm on 2020/4/8.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CJMRouterPageId         @"page_id"      // 页面id
#define CJMRouterPageClass      @"page_class"   // 页面类名
#define CJMRouterPageName       @"page_name"    // 页面名称


@interface CJMRouterTable : NSObject
@property (nonatomic, readonly) NSDictionary *_Nullable pageIdList;      /// 通过page id 查找的表
@property (nonatomic, readonly) NSDictionary *_Nullable pageClassNameList;   /// 通过page name 查找的表

#pragma mark - 初始化

- (instancetype _Nonnull )initWithPageIdList:(NSDictionary *_Nullable)pageIdList;
- (instancetype _Nonnull )initWithPageClassNameList:(NSDictionary *_Nullable)pageClassNameList;


#pragma mark - 获取pageId

- (NSString *_Nullable)pageIdByPageClassName:(NSString *_Nullable)pageClassName;


#pragma mark - 获取pageClassName

- (NSString *_Nullable)pageClassNameByPageId:(NSString *_Nullable)pageId;


#pragma mark - 获取pageName

- (NSString *_Nullable)pageNameByPageId:(NSString *_Nullable)pageId;
- (NSString *_Nullable)pageNameByPageClassName:(NSString *_Nullable)pageClassName;


#pragma mark - 获取ViewController

- (UIViewController *_Nullable)viewControllerByPageId:(NSString *_Nullable)pageId;
- (UIViewController *_Nullable)viewControllerByPageClassName:(NSString *_Nullable)_NullablepageClassName;


@end
