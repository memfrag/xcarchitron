//
//  MEMachOVersionMinLoadCommand.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOVersionMinLoadCommand.h"
#import <mach-o/loader.h>

@interface MEMachOVersionMinLoadCommand ()

@property (nonatomic, readwrite) uint32_t major;
@property (nonatomic, readwrite) uint32_t minor;
@property (nonatomic, readwrite) uint32_t revision;

@end

@implementation MEMachOVersionMinLoadCommand

@synthesize major = _major;
@synthesize minor = _minor;
@synthesize revision = _revision;

- (id)initWithHeader:(void *)header
{
    self = [super initWithHeader:header];
    if (self) {
        struct version_min_command versionHeader = *(struct version_min_command *)header;
        uint32_t version = versionHeader.version;
        self.major = (version >> 16) & 0x0000FFFFL;
        self.major = (version >> 8) & 0x000000FFL;
        self.revision = version & 0x000000FFL;
    }
    
    return self;
}

@end
