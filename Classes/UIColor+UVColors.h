//
//  UIColor+UVColors.h
//  UserVoice
//
//  Created by TJ Coyle on 9/5/19.
//  Copyright © 2019 UserVoice Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (UVColors)

+(UIColor *)primaryText;
+(UIColor *)secondaryText;
+(UIColor *)backgroundColor;
+(UIColor *)green;
+(UIColor *)reallyLightGray;
+(UIColor *)mediumGray;
+(UIColor *)darkGray;
+(UIColor *)reallyDarkGray;

+(UIColor *)uvDarkGray;
+(UIColor *)alwaysLightPrimaryText;
+(UIColor *)alwaysLightSecondaryText;

- (UIColor *)inverseColor;

@end

NS_ASSUME_NONNULL_END
