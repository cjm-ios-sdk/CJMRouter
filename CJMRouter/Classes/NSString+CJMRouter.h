//
//  NSString+CJMRouter.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/10.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (CJMRouter)


/**
 * @brief 是否是http或者https
 */
- (BOOL)cjmr_isHttpURLString;

/**
 * @brief 获取url中的scheme
 */
- (NSString *_Nullable)cjmr_scheme;

/**
 * @brief 获取url中的path
 */
- (NSString *_Nullable)cjmr_path;

/**
 * @brief 获取url中的参数
 */
- (NSDictionary *_Nullable)cjmr_paramters;

@end

