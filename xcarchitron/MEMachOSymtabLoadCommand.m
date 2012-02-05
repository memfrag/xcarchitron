//
//  MEMachOSymtabLoadCommand.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOSymtabLoadCommand.h"
#import <mach-o/loader.h>

@interface MEMachOSymtabLoadCommand ()

@property (nonatomic, readwrite) uint32_t symbolsFileOffset;
@property (nonatomic, readwrite) uint32_t symbolCount;
@property (nonatomic, readwrite) uint32_t stringsFileOffset;
@property (nonatomic, readwrite) uint32_t stringsSize;

@end

@implementation MEMachOSymtabLoadCommand

@synthesize symbolsFileOffset = _symbolsFileOffset;
@synthesize symbolCount = _symbolCount;
@synthesize stringsFileOffset = _stringsFileOffset;
@synthesize stringsSize = _stringsSize;

- (id)initWithHeader:(void *)header
{
    self = [super initWithHeader:header];
    if (self) {
        struct symtab_command symtabHeader = *(struct symtab_command *)header;
        self.symbolsFileOffset = symtabHeader.symoff;
        self.symbolCount = symtabHeader.nsyms;
        self.stringsFileOffset = symtabHeader.stroff;
        self.stringsSize = symtabHeader.strsize;
    }
    
    return self;
}

@end
