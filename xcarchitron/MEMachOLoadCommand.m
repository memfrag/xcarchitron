//
//  MEMachOLoadCommand.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOLoadCommand.h"
#import <mach-o/loader.h>

@interface MEMachOLoadCommand ()

@property (nonatomic, readwrite) uint32_t command;
@property (nonatomic, readwrite) uint32_t commandSize;

@end


@implementation MEMachOLoadCommand

@synthesize command = _command;
@synthesize commandSize = _commandSize;

- (id)initWithHeader:(void *)header
{
    self = [super init];
    if (self) {
        self.command = ((struct load_command *)header)->cmd;
        self.commandSize = ((struct load_command *)header)->cmdsize;
    }
    
    return self;
}

@end
