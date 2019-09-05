//
//  UIColor+UVColors.m
//  UserVoice
//
//  Created by TJ Coyle on 9/5/19.
//  Copyright © 2019 UserVoice Inc. All rights reserved.
//

#import "UIColor+UVColors.h"
#import <UIKit/UIKit.h>

@implementation UIColor (UVColors)

+(UIColor *)primaryText
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [UIColor whiteColor] :
            [UIColor blackColor];
        }];
    } else {
        return [UIColor blackColor];
    }
}

+(UIColor *)secondaryText
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [UIColor lightGrayColor] :
            [UIColor grayColor];
        }];
    } else {
        return [UIColor grayColor];
    }
}

+(UIColor *)backgroundColor
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [UIColor blackColor] :
            [UIColor whiteColor];
        }];
    } else {
        return [UIColor whiteColor];
    }
}

- (UIColor *)inverseColor {
    CGFloat alpha;

    CGFloat white;
    if ([self getWhite:&white alpha:&alpha]) {
        return [UIColor colorWithWhite:1.0 - white alpha:alpha];
    }

    CGFloat hue, saturation, brightness;
    if ([self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:1.0 - hue saturation:1.0 - saturation brightness:1.0 - brightness alpha:alpha];
    }

    CGFloat red, green, blue;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return [UIColor colorWithRed:1.0 - red green:1.0 - green blue:1.0 - blue alpha:alpha];
    }

    return nil;
}

+(UIColor *)green
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [UIColor colorWithRed:0 green:224/255.0f blue:52/255.0f alpha:1] :
            [UIColor colorWithRed:0 green:127/255.0f blue:25/255.0f alpha:1];
        }];
    } else {
        return [UIColor colorWithRed:0 green:127/255.0f blue:25/255.0f alpha:1];
    }
}

+(UIColor *)reallyLightGray
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [[UIColor uvLightGray] inverseColor] :
            [UIColor uvLightGray];
        }];
    } else {
        return [UIColor uvLightGray];
    }
}

+(UIColor *)mediumGray
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [[UIColor lightGrayColor] inverseColor] :
            [UIColor lightGrayColor];
        }];
    } else {
        return [UIColor lightGrayColor];
    }
}

+(UIColor *)darkGray
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [[UIColor darkGrayColor] inverseColor] :
            [UIColor darkGrayColor];
        }];
    } else {
        return [UIColor darkGrayColor];
    }
}

+(UIColor *)alwaysLightPrimaryText
{
    return [UIColor whiteColor];
}

+(UIColor *)alwaysLightSecondaryText
{
    return [UIColor lightGrayColor];
}

+(UIColor *)reallyDarkGray
{
    if (@available(iOS 13.0, *)) {
        return [[UIColor alloc] initWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ?
            [[UIColor uvDarkGray] inverseColor] :
            [UIColor uvDarkGray];
        }];
    } else {
        return [UIColor uvDarkGray];
    }
}

+(UIColor *)uvLightGray
{
    return [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
}

+(UIColor *)uvDarkGray
{
    return [UIColor colorWithRed:48/255.0f green:48/255.0f blue:48/255.0f alpha:1];
}

//.97 .97 .97    247/247/247   really light gray    *reallyLightGray
//.85 .85 .85    204/204/204   medium gray          *mediumGray
//.58 .58 .60    148/148/148   another medium gray  *mediumGray
//.69 .69 .72    176/176/176   another medium gray  *mediumGray
//.6  .6  .6     153/153/153   another medium gray  *mediumGray
//.78 .78 .80    204/204/204   another medium gray  *mediumGray


//.41 .42 .43    107/107/107   dark gray            *darkGray
//.0  .5  .1     0/127/25      darker green color    (dark: 0/224/52) *gree
//.19 .20 .20    48/48/48      really dark gray     *reallyDarkGray
//.937 .937 .957                                    *reallyLightGray
//.9  .9  .9                                        *reallyLightGray


//170 = lightGrayColor
//85  = darkGrayColor
//128 = grayColor


@end
