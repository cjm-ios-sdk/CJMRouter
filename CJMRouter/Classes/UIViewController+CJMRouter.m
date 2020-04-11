//
//  UIViewController+CJMRouter.m
//  CJMRouter
//
//  Created by chenjm on 2020/4/9.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import "UIViewController+CJMRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (CJMRouter)

- (NSDictionary *)cjmr_paramters {
    return (NSDictionary *)objc_getAssociatedObject(self, @selector(cjmr_paramters));
}

- (void)setCjmr_paramters:(NSDictionary *)cjmr_paramters {
    objc_setAssociatedObject(self, @selector(cjmr_paramters), cjmr_paramters, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
