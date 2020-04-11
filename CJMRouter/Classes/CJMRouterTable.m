//
//  CJMRouterTable.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/8.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import "CJMRouterTable.h"

@interface CJMRouterTable ()
@end

@implementation CJMRouterTable


#pragma mark - 初始化

- (instancetype)initWithPageIdList:(NSDictionary *)pageIdList {
    self = [super init];
    if (self) {
        _pageIdList = [pageIdList copy];
        
        NSMutableDictionary *mutableList = [[NSMutableDictionary alloc] initWithCapacity:_pageIdList.count];
        for (NSString *key in _pageIdList.allKeys) {
            NSMutableDictionary *mutableInfo = [_pageIdList[key] mutableCopy];
            mutableInfo[CJMRouterPageId] = key;
            [mutableInfo removeObjectForKey:CJMRouterPageClass];
            [mutableList setValue:mutableInfo forKey:CJMRouterPageClass];
        }
        _pageClassNameList = mutableList;
    }
    return self;
}

- (instancetype)initWithPageClassNameList:(NSDictionary *)pageClassNameList {
    self = [super init];
    if (self) {
        _pageClassNameList = [pageClassNameList copy];
        
        NSMutableDictionary *mutableList = [[NSMutableDictionary alloc] initWithCapacity:_pageClassNameList.count];
        for (NSString *key in _pageClassNameList.allKeys) {
            NSMutableDictionary *mutableInfo = [_pageClassNameList[key] mutableCopy];
            mutableInfo[CJMRouterPageClass] = key;
            [mutableInfo removeObjectForKey:CJMRouterPageId];
            [mutableList setValue:mutableInfo forKey:CJMRouterPageId];
        }
        _pageClassNameList = mutableList;
    }
    return self;
}


#pragma mark - 获取pageId

- (NSString *)pageIdByPageClassName:(NSString *)pageClassName {
    if (!pageClassName) {
        return nil;
    }
    return _pageClassNameList[pageClassName][CJMRouterPageId];
}


#pragma mark - 获取pageClassName

- (NSString *)pageClassNameByPageId:(NSString *)pageId {
    if (!pageId) {
        return nil;
    }
    return _pageIdList[pageId][CJMRouterPageClass];
}

#pragma mark - 获取pageName

- (NSString *)pageNameByPageId:(NSString *)pageId {
    if (!pageId) {
        return nil;
    }
    return _pageIdList[pageId][CJMRouterPageName];
}

- (NSString *)pageNameByPageClassName:(NSString *)pageClassName {
    if (!pageClassName) {
        return nil;
    }
    return _pageClassNameList[pageClassName][CJMRouterPageName];
}


#pragma mark - 获取ViewController

- (UIViewController *)viewControllerByPageId:(NSString *)pageId {
    NSString *pageClassName = [self pageClassNameByPageId:pageId];
    Class aClass = NSClassFromString(pageClassName);
    return [[aClass alloc] init];
}

- (UIViewController *)viewControllerByPageClassName:(NSString *)pageClassName {
    Class aClass = NSClassFromString(pageClassName);
    return [[aClass alloc] init];
}


@end
