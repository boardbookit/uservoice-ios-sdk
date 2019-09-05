//
//  UVStyleSheet.m
//  UserVoice
//
//  Created by UserVoice on 10/28/09.
//  Copyright 2009 UserVoice Inc. All rights reserved.
//

#import "UVStyleSheet.h"
#import "UIColor+UVColors.h"

@implementation UVStyleSheet

static UVStyleSheet *instance;

+ (UVStyleSheet *)instance {
    if (instance == nil) {
        instance = [UVStyleSheet new];
        instance.loadingViewBackgroundColor = [UIColor reallyLightGray];
        instance.preferredStatusBarStyle = UIStatusBarStyleDefault;
        instance.navigationBarTintColor = [UINavigationBar appearance].tintColor;
        instance.navigationBarTranslucency = YES;
    }
    return instance;
}

@end
