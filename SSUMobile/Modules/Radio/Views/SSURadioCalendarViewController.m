//
//  UIViewController+SSURadioCalendarViewController.m
//  SSUMobile
//
//  Created by DANIEL THOMPSON on 4/26/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

#import "SSURadioCalendarViewController.h"
@import AVFoundation;
@import SafariServices;


@interface SSURadioCalendarViewController()
@end

/*
    The purpose of this class is to allow the user to open a webview of the calendar on the radio,
    but not worry about hitting the nav bar Back button and getting sent back to the home screen.
    Therefore, a new viewcontroller was made solely for this webview that is loaded on startup, 
    allowing the user to go back to the radio when they wish.
 */

@implementation SSURadioCalendarViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   
    //Load the webview.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sonomastateradio.com/copy-of-schedule-1"]]];
    [self.view addSubview:webView];
    

}


@end
