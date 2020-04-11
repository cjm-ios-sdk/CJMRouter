//
//  CJMAppDelegate.h
//  CJMRouter
//
//  Created by chenjm on 04/08/2020.
//  Copyright (c) 2020 chenjm. All rights reserved.
//

@import UIKit;

@interface CJMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (instancetype)shareInstance;

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController;

@end
