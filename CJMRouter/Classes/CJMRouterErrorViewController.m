//
//  CJMRouterErrorViewController.h
//  CJMRouter
//
//  Created by chenjm on 2020/4/8.
//  Copyright © 2020年 chenjm. All rights reserved.
//

#import "CJMRouterErrorViewController.h"
#import "UIViewController+CJMRouter.h"

@interface CJMRouterErrorViewController ()
@end

@implementation CJMRouterErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"页面出错";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _errorMessage = [NSString stringWithFormat:@"error! cjmr_paramters:\n%@", self.cjmr_paramters];
    
    _textView = ({
        CGFloat w = self.view.bounds.size.width - 30;
        CGFloat h = self.view.bounds.size.height - 30;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 20, w, h)];
        [self.view addSubview:textView];
        textView.text = _errorMessage;
        textView.center = self.view.center;
        textView.editable = NO;
        textView.font = [UIFont systemFontOfSize:16];
        textView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




@end
