//
//  MEProvisioningProfile.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEProvisioningProfile.h"

@interface MEProvisioningProfile () {
@private
    NSDictionary *properties;
}

- (void)loadProperties:(NSURL *)url;

@end

@implementation MEProvisioningProfile

- (id)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        [self loadProperties:url];
    }
    return self;
}

- (void)dealloc
{
    [properties release];
    [super dealloc];
}


- (void)loadProperties:(NSURL *)url
{
    NSData *file = [NSData dataWithContentsOfURL:url];
    if (file) {
        NSData *startData = [@"<?xml" dataUsingEncoding:NSUTF8StringEncoding];
        NSData *stopData = [@"</plist>" dataUsingEncoding:NSUTF8StringEncoding];
        
        NSRange startRange = [file rangeOfData:startData options:0 range:NSMakeRange(0, file.length - 1)];
        
        if (startRange.location != NSNotFound) {
            NSRange stopRange = [file rangeOfData:stopData options:0 range:NSMakeRange(0, file.length - 1)];
            
            if (stopRange.location != NSNotFound) {
                NSRange plistRange = NSMakeRange(startRange.location, stopRange.location - startRange.location + @"</plist>".length); 
                NSData *plistData = [file subdataWithRange:plistRange];
                NSString *plistString = [[[NSString alloc] initWithData:plistData encoding:NSUTF8StringEncoding] autorelease];
                properties = [[plistString propertyList] retain];
            }
        }
    }
}

- (NSArray *)appIdentifierPrefix
{
    if (properties) {
        return [properties objectForKey:@"ApplicationIdentifierPrefix"];
    }
    return nil;
}

- (NSString *)appIdentifier;
{
    if (properties) {
        NSDictionary *entitlements = [properties objectForKey:@"Entitlements"];
        if (entitlements) {
            return [entitlements objectForKey:@"application-identifier"];
        }
    }
    return nil;
}

- (NSDate *)creationDate;
{
    if (properties) {
        return [properties objectForKey:@"CreationDate"];
    }
    return nil;
}

- (NSDate *)expirationDate;
{
    if (properties) {
        return [properties objectForKey:@"ExpirationDate"];
    }
    return nil;
}

- (NSString *)name;
{
    if (properties) {
        return [properties objectForKey:@"Name"];
    }
    return nil;
}

- (NSArray *)provisionedDevices;
{
    if (properties) {
        return [properties objectForKey:@"ProvisionedDevices"];
    }
    return nil;
}

- (NSString *)timeToLive;
{
    if (properties) {
        return [properties objectForKey:@"TimeToLive"];
    }
    return nil;
}

- (NSString *)uuid;
{
    if (properties) {
        return [properties objectForKey:@"UUID"];
    }
    return nil;
}

@end
