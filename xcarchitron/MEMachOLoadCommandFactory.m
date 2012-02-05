//
//  MEMachOLoadCommandFactory.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOLoadCommandFactory.h"
#import <mach-o/loader.h>

@implementation MEMachOLoadCommandFactory

+ (MEMachOLoadCommand *)loadCommandFromPointer:(void *)pointer
{
    struct load_command *header = (struct load_command *)pointer;
    
    if (header == NULL) {
        return nil;
    }
    
    MEMachOLoadCommand *command = nil;
    switch (header->cmd) {
        case LC_UUID:
            command = [[MEMachOUUIDLoadCommand alloc] initWithHeader:header];
            break;
        case LC_VERSION_MIN_IPHONEOS:
            command = [[MEMachOVersionMinLoadCommand alloc] initWithHeader:header];
            break;
        case LC_SYMTAB:
            command = [[MEMachOSymtabLoadCommand alloc] initWithHeader:header];
            break;
        default:
            command = [[MEMachOLoadCommand alloc] initWithHeader:header];
            break;
    }
    
    return [command autorelease];
}

@end
