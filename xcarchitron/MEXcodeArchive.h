//
//  MEXcodeArchive.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "MEProvisioningProfile.h"

@interface MEXcodeArchive : NSObject

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSURL *appBundleURL;
@property (nonatomic, readonly) NSURL *executableURL;
@property (nonatomic, readonly) NSImage *icon;
@property (nonatomic, readonly) NSDate *creationDate;
@property (nonatomic, readonly) NSString *creationDateString;
@property (nonatomic, readonly) NSString *comment;
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) NSString *schemeName;
@property (nonatomic, readonly) MEProvisioningProfile *provisioningProfile;

- (id)initWithURL:(NSURL *)url;

@end
