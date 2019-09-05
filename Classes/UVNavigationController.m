//
//  UVNavigationController.m
//  UserVoice
//
//  Created by Austin Taylor on 11/1/12.
//  Copyright (c) 2012 UserVoice Inc. All rights reserved.
//

#import "UVNavigationController.h"
#import "UVStyleSheet.h"
#import "UIColor+UVColors.h"

@implementation UVNavigationController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    if (@available(iOS 13.0, *)) {
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    }
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [UVStyleSheet instance].preferredStatusBarStyle;
}

@end
