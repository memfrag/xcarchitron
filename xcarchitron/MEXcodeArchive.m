//
//  MEXcodeArchive.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEXcodeArchive.h"

@interface MEXcodeArchive () {
@private
    NSDictionary *info;
    MEProvisioningProfile *provisioningProfile;
}
@end

@implementation MEXcodeArchive

@synthesize url = _url;

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        _url = [url retain];
        info = [[NSDictionary dictionaryWithContentsOfURL:[url URLByAppendingPathComponent:@"/Info.plist"]] retain];
    }
    
    return self;
}

- (void)dealloc
{
    [provisioningProfile release];
    [info release];
    [_url release];
    [super dealloc];
}

- (NSString *)name
{
    if (info) {
        return [info objectForKey:@"Name"];
    }
    else {
        return nil;
    }
}

- (NSURL *)appBundleURL
{
    if (info) {
        NSDictionary *properties = [info objectForKey:@"ApplicationProperties"];
        if (properties) {
            NSString *appPath = [properties objectForKey:@"ApplicationPath"];
            if (appPath) {
                NSURL *url = [self.url URLByAppendingPathComponent:@"Products"];
                return [url URLByAppendingPathComponent:appPath];
            }
        }
    }
    
    return nil;
}

- (NSURL *)executableURL
{
    if (info) {
        return [self.appBundleURL URLByAppendingPathComponent:self.name];            
    }
    
    return nil;
}

- (NSImage *)icon
{
    if (info) {
        NSDictionary *properties = [info objectForKey:@"ApplicationProperties"];
        if (properties) {
            NSArray *iconPaths = [properties objectForKey:@"IconPaths"];
            if (iconPaths) {
                NSString *iconPath = [iconPaths objectAtIndex:0];
                NSURL *iconUrl = [self.url URLByAppendingPathComponent:@"Products"];
                iconUrl = [iconUrl URLByAppendingPathComponent:iconPath];
                return [[NSImage alloc] initWithContentsOfURL:iconUrl];
            }
        }    
    }
    
    return nil;
}

- (NSDate *)creationDate
{
    if (info) {
        return [info objectForKey:@"CreationDate"];
    }
    return nil;
}

- (NSString *)creationDateString
{
    NSDate *creationDate = self.creationDate;
    if (creationDate) {
        NSDateFormatter *userVisibleDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [userVisibleDateFormatter setDateStyle:kCFDateFormatterLongStyle];
        [userVisibleDateFormatter setTimeStyle:kCFDateFormatterLongStyle];
        return [userVisibleDateFormatter stringFromDate:creationDate];
    }
    return nil;
}

- (NSString *)comment
{
    if (info) {
        return [info objectForKey:@"Comment"];
    }
    return nil;
}

- (NSString *)bundleIdentifier
{
    if (info) {
        NSDictionary *properties = [info objectForKey:@"ApplicationProperties"];
        if (properties) {
            return [properties objectForKey:@"CFBundleIdentifier"];
        }
    }
    return nil;
}

- (NSString *)version
{
    if (info) {
        NSDictionary *properties = [info objectForKey:@"ApplicationProperties"];
        if (properties) {
            return [properties objectForKey:@"CFBundleShortVersionString"];
        }
    }
    return nil;
}

- (NSString *)status
{
    if (info) {
        return [info objectForKey:@"Status"];
    }
    return nil;
}

- (NSString *)schemeName
{
    if (info) {
        return [info objectForKey:@"SchemeName"];
    }
    return nil;
}

- (MEProvisioningProfile *)provisioningProfile
{
    if (info) {
        if (provisioningProfile == nil) {
            NSURL *url = [self.appBundleURL URLByAppendingPathComponent:@"embedded.mobileprovision"];
            provisioningProfile = [[MEProvisioningProfile alloc] initWithURL:url];
        }
        return provisioningProfile;
    }
    return nil;
}

@end
