//
//  UVArticleViewController.m
//  UserVoice
//
//  Created by Austin Taylor on 5/8/12.
//  Copyright (c) 2012 UserVoice Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UVArticleViewController.h"
#import "UVSession.h"
#import "UVContactViewController.h"
#import "UVStyleSheet.h"
#import "UVBabayaga.h"
#import "UVDeflection.h"
#import "UVUtils.h"
#import "UIColor+UVColors.h"

@implementation UVArticleViewController {
    UILabel *_footerLabel;
    UIButton *_yes;
    UIButton *_no;
}

- (void)loadView {
    [super loadView];
    [UVBabayaga track:VIEW_ARTICLE id:_article.articleId];
    self.view = [[UIView alloc] initWithFrame:[self contentFrame]];
    self.navigationItem.title = @"";

    CGFloat footerHeight = 46;
    _webView = [UIWebView new];
    _webView.delegate = self;
    NSString *section = _article.topicName ? [NSString stringWithFormat:@"%@ / %@", NSLocalizedStringFromTableInBundle(@"Knowledge Base", @"UserVoice", [UserVoice bundle], nil), _article.topicName] : NSLocalizedStringFromTableInBundle(@"Knowledge base", @"UserVoice", [UserVoice bundle], nil);
    NSString *linkColor;
    if (IOS7) {
        linkColor = [UVUtils colorToCSS:self.view.tintColor];
    } else {
        linkColor = @"default";
    }
    NSString *html = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"user-scalable=no, width=device-width, initial-scale=1.0, maximum-scale=1.0\"/><link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdn.uservoice.com/stylesheets/vendor/typeset.css\"/><style>a { color: %@; } img { max-width: 100%%; width: auto; height: auto; }</style></head><body class=\"typeset\" style=\"font-family: HelveticaNeue; margin: 1em; font-size: 15px\"><h5 style='font-weight: normal; color: #999; font-size: 13px'>%@</h5><h3 style='margin-top: 10px; margin-bottom: 20px; font-size: 18px; font-family: HelveticaNeue-Medium; font-weight: normal; line-height: 1.3'>%@</h3>%@</body></html>", linkColor, section, _article.question, _article.answerHTML];
    _webView.backgroundColor = [UIColor backgroundColor];
    for (UIView* shadowView in [[_webView scrollView] subviews]) {
        if ([shadowView isKindOfClass:[UIImageView class]]) {
            [shadowView setHidden:YES];
        }
    }
    [_webView loadHTMLString:html baseURL:nil];
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, footerHeight, 0);
    _webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, footerHeight, 0);

    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor reallyLightGray];
    UIView *bg = [UIView new];
    bg.backgroundColor = footer.backgroundColor;
    bg.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *border = [UIView new];
    border.backgroundColor = [UIColor mediumGray];
    UILabel *label = [UILabel new];
    label.text = NSLocalizedStringFromTableInBundle(@"Was this article helpful?", @"UserVoice", [UserVoice bundle], nil);
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor darkGray];
    label.backgroundColor = [UIColor clearColor];
    _footerLabel = label;
    UIButton *yes = [UIButton new];
    [yes setTitle:NSLocalizedStringFromTableInBundle(@"Yes!", @"UserVoice", [UserVoice bundle], nil) forState:UIControlStateNormal];
    [yes setTitleColor:([UIColor green]) forState:UIControlStateNormal];
    [yes addTarget:self action:@selector(yesButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    _yes = yes;
    UIButton *no = [UIButton new];
    [no setTitle:NSLocalizedStringFromTableInBundle(@"No", @"UserVoice", [UserVoice bundle], nil) forState:UIControlStateNormal];
    [no setTitleColor:[UIColor secondaryText] forState:UIControlStateNormal];
    [no addTarget:self action:@selector(noButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    _no = no;
    NSArray *constraints = @[
        @"|[border]|", @"|-[label]-(>=10)-[yes]-30-[no]-30-|",
        @"V:|[border(==1)]", @"V:|-15-[label]", (IOS7 ? @"V:|-6-[yes]" : @"V:|-12-[yes]"), (IOS7 ? @"V:|-6-[no]" : @"V:|-12-[no]")
    ];
    [self configureView:footer
               subviews:NSDictionaryOfVariableBindings(border, label, yes, no)
            constraints:constraints];

    [self configureView:self.view
               subviews:NSDictionaryOfVariableBindings(_webView, footer, bg)
            constraints:@[@"V:|[_webView]|", @"V:[footer][bg]|", @"|[_webView]|", @"|[footer]|", @"|[bg]|"]];
    [self.view addConstraint:[footer.heightAnchor constraintEqualToConstant:footerHeight]];
    [self.view addConstraint:[footer.bottomAnchor constraintEqualToAnchor:self.view.readableContentGuide.bottomAnchor]];
    [self.view bringSubviewToFront:footer];
    [self.view bringSubviewToFront:bg];
}


- (BOOL)webView:(UIWebView *)view shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return ![[UIApplication sharedApplication] openURL:request.URL];
    }
    return YES;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_helpfulPrompt) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        } else if (buttonIndex == 1) {
            [self dismiss];
        }
    } else {
        if (buttonIndex == 0) {
            [self presentModalViewController:[UVContactViewController new]];
        }
    }
}

- (void)yesButtonTapped {
    [UVBabayaga track:VOTE_ARTICLE id:_article.articleId];
    if (_deflectingType) {
        [UVDeflection trackDeflection:@"helpful" deflectingType:_deflectingType deflector:_article];
    }
    if (_helpfulPrompt) {
        // Do you still want to contact us?
        // Yes, go to my message
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:_helpfulPrompt
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"Cancel", @"UserVoice", [UserVoice bundle], nil)
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:_returnMessage, NSLocalizedStringFromTableInBundle(@"No, I'm done", @"UserVoice", [UserVoice bundle], nil), nil];
        [actionSheet showInView:self.view];
    } else {
        _yes.hidden = YES;
        _no.hidden = YES;
        _footerLabel.text = NSLocalizedStringFromTableInBundle(@"Great! Glad we could help.", @"UserVoice", [UserVoice bundle], nil);
    }
}

- (void)noButtonTapped {
    if (_deflectingType) {
        [UVDeflection trackDeflection:@"not_helpful" deflectingType:_deflectingType deflector:_article];
    }
    if (_helpfulPrompt) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"Would you like to contact us?", @"UserVoice", [UserVoice bundle], nil)
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedStringFromTableInBundle(@"No", @"UserVoice", [UserVoice bundle], nil)
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedStringFromTableInBundle(@"Yes", @"UserVoice", [UserVoice bundle], nil), nil];
        [actionSheet showInView:self.view];
    }
}

@end
