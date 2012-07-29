//
//  MEMachOSection.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOSection.h"
#import <mach-o/arch.h>
#import <mach-o/loader.h>
#import <mach-o/getsect.h>

@interface MEMachOSection ()

@property (nonatomic, copy, readwrite) NSString *segmentName;
@property (nonatomic, copy, readwrite) NSString *sectionName;
@property (nonatomic, assign) struct section sectionHeader;
@property (nonatomic, retain, readwrite) NSData *sectionData;

@end

@implementation MEMachOSection

@synthesize segmentName = _segmentName;
@synthesize sectionName = _sectionName;
@synthesize sectionHeader = _sectionHeader;
@synthesize sectionData = _sectionData;

+ (MEMachOSection *)sectionFromBasePointer:(void *)base
                                 segment:(NSString *)segmentName
                                 section:(NSString *)sectionName
{
    MEMachOSection *machOSection;
    machOSection = [[MEMachOSection alloc] init];
    
    machOSection.segmentName = segmentName;
    machOSection.sectionName = sectionName;
    
    struct mach_header *machHeader = (struct mach_header *)base;
    
    const struct section *section = getsectbynamefromheader(machHeader,
                                                            [segmentName UTF8String],
                                                            [sectionName UTF8String]);
    
    if (section == NULL) {
        [machOSection release];
        return nil;
    }
    
    machOSection.sectionHeader = *section;
    
    uint32_t dataSize = 0;
    char *dataPointer = getsectdatafromheader(machHeader,
                                              [segmentName UTF8String],
                                              [sectionName UTF8String],
                                              &dataSize);
    if (dataPointer == NULL || dataSize == 0) {
        [machOSection release];
        return nil;
    }
    
    machOSection.sectionData = [NSData dataWithBytes:dataPointer length:dataSize];
    
    return [machOSection autorelease];
}

- (void)dealloc
{
    self.segmentName = nil;
    self.sectionName = nil;
    self.sectionData = nil;
    [super dealloc];
}

- (uint32_t)sectionAddress
{
    return self.sectionHeader.addr;
}

- (uint32_t)sectionSize
{
    return self.sectionHeader.size;
}

- (uint32_t)fileOffset
{
    return self.sectionHeader.offset;
}

- (uint32_t)sectionAlignment
{
    return self.sectionHeader.align;
}

- (uint32_t)relocationEntriesFileOffset
{
    return self.sectionHeader.reloff;
}

- (uint32_t)relocationEntryCount
{
    return self.sectionHeader.nreloc;
}

- (uint32_t)sectionFlags
{
    return self.sectionHeader.flags;
}

@end
