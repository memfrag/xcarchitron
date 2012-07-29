//
//  MEProvisioningProfile.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEProvisioningProfile : NSObject

@property (nonatomic, readonly) NSArray *appIdentifierPrefix;
@property (nonatomic, readonly) NSString *appIdentifier;
@property (nonatomic, readonly) NSDate *creationDate;
@property (nonatomic, readonly) NSDate *expirationDate;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSArray *provisionedDevices;
@property (nonatomic, readonly) NSString *timeToLive;
@property (nonatomic, readonly) NSString *uuid;

- (id)initWithURL:(NSURL *)url;

@end
