//
//  CJMRouterRequest.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/10.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJMRouterRequest : NSObject
@property (nonatomic, readonly) BOOL isHttp;
@property (nonatomic, copy) NSString *_Nullable urlString;
@property (nonatomic, copy) NSDictionary *_Nullable paramters;
@property (nonatomic, readonly) NSString *_Nullable urlScheme;
@property (nonatomic, readonly) NSString *_Nullable urlPath;
@property (nonatomic, readonly) NSDictionary *_Nullable urlParamters;
@property (nonatomic, readonly) NSDictionary *_Nullable allParamters;

- (instancetype _Nonnull )initWithUrlString:(NSString *_Nullable)urlString paramters:(NSDictionary *_Nullable)paramters;

@end
