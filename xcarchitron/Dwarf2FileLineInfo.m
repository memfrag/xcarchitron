//
//  Dwarf2FileLineInfo.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2FileLineInfo.h"

@interface Dwarf2FileLineInfo ()

@property (nonatomic, readwrite) uint32_t address;
@property (nonatomic, copy, readwrite) NSString *path;
@property (nonatomic, copy, readwrite) NSString *filename;
@property (nonatomic, copy, readwrite) NSString *fullPath;
@property (nonatomic, readwrite) uint32_t line;

@end


@implementation Dwarf2FileLineInfo

@synthesize address = _address;
@synthesize path = _path;
@synthesize filename = _filename;
@synthesize fullPath = _fullPath;
@synthesize line = _line;

- (id)initWithAddress:(uint32_t)address
                 path:(NSString *)path
             filename:(NSString *)filename
                 line:(uint32_t)line
{
    self = [super init];
    if (self) {
        self.address = address;
        self.path = path;
        self.filename = filename;
        self.line = line;
        
        if (path) {
            self.fullPath = [path stringByAppendingPathComponent:filename];
        } else {
            self.fullPath = filename;
        }
    }
    
    return self;
}

- (void)dealloc
{
    self.path = nil;
    self.filename = nil;
    self.fullPath = nil;
    [super dealloc];
}

@end
