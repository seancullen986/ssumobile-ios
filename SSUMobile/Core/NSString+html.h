//
//  NSString+html.h
//  SSUMobile
//
//  Created by Andrew Huss on 1/30/13.
//  Copyright (c) 2013 Computer Science. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (html)
- (NSString *)stringByDecodingXMLEntities;
@end
