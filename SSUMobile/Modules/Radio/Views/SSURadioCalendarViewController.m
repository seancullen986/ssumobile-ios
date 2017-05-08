//
//  SSURadioCalendarViewController.m
//  SSUMobile
//
//  Created by DANIEL THOMPSON on 4/26/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

#import "SSURadioCalendarViewController.h"
#import "SSUCommunicator.h"
#import "SSULogging.h"
#import "SSUMobile-Swift.h"
@import WebKit;
@import Masonry;
@import MBProgressHUD;


@interface SSURadioCalendarViewController() <WKNavigationDelegate>

@property (nonatomic) WKWebView * webView;

@end

/*
    The purpose of this class is to allow the user to open a webview of the calendar on the radio,
    but not worry about hitting the nav bar Back button and getting sent back to the home screen.
    Therefore, a new viewcontroller was made solely for this webview that is loaded on startup, 
    allowing the user to go back to the radio when they wish.
 */

@implementation SSURadioCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KSUN Schedule";
   
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURL * url = [[SSURadioModule sharedInstance] radioScheduleURL];
    if (url == nil) {
        SSULogError(@"Failed to load radio schedule from settings, using fallback value");
        url = [NSURL URLWithString:@"http://www.sonomastateradio.com/copy-of-schedule-1"];
    }
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView = webView;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.webView.isLoading) {
        [self.webView stopLoading];
        [SSUCommunicator setNetworkActivityIndicatorVisible:NO];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

#pragma mark - WKNavigationDelegate

- (void) webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [SSUCommunicator setNetworkActivityIndicatorVisible:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SSUCommunicator setNetworkActivityIndicatorVisible:NO];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


@end
