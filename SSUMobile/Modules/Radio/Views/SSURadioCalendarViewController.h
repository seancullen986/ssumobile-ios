//
//  SSURadioCalendarViewController.h
//  SSUMobile
//
//  Created by DANIEL THOMPSON on 4/26/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

@import UIKit;
#import "SSURadioViewController.h"
#import "SSURadioStreamer.h"


/**
 Interface for RadioCalendar's viewcontroller.
 Purpose of the viewcontroller is to view the SSURadio calendar without simply adding
 the webview to the radios subview.
 Opens a new view and adds the webview to its subview for simpler navigation.
 */
@interface SSURadioCalendarViewController : UIViewController
@end
