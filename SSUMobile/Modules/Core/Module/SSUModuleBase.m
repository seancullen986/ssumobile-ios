//
//  SSUModuleBase.m
//  SSUMobile
//
//  Created by Eric Amorde on 9/8/15.
//  Copyright (c) 2015 Sonoma State University Department of Computer Science. All rights reserved.
//

#import "SSUModuleBase.h"
#import "SSULogging.h"

@interface SSUModuleBase()

@property (nonatomic, strong, readwrite) NSDateFormatter * dateFormatter;

@end

@implementation SSUModuleBase

+ (instancetype) sharedInstance {
    SSULogError(@"sharedInstance not implemented by subclass of SSUModuleBase");
    return nil;
}

/** 
 Marks the file at URL as excluded from iCloud backups. Appropriate use is required for
 approval on the App Store
 */
- (BOOL) setExcludeFromBackupAttributeOnResourceAtURL:(nullable NSURL *)url toValue:(BOOL)excluded {
    NSError *error = nil;
    BOOL success = [url setResourceValue:@(excluded)
                                  forKey:NSURLIsExcludedFromBackupKey
                                   error:&error];
    if(!success){
        SSULogError(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
    }
        
    return success;
}



//MARK: Default implementations for SSUModule

- (NSString *) title {
    NSAssert(NO, @"Subclasses of %@ must provide an implementation for %s", [self class], __FUNCTION__);
    return nil;
}

- (NSString *) identifier {
    NSAssert(NO, @"Subclasses of %@ must provide an implementation for %s", [self class], __FUNCTION__);
    return nil;
}

- (void) setup {}
- (void) updateData:(void (^)())completion {}
- (void) clearCachedData {}

@end
