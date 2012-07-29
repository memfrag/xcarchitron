//
//  Dwarf2StatementProgram.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2StatementProgram.h"

@interface Dwarf2StatementProgram ()

@property (nonatomic, readwrite) uint32_t totalLength;
@property (nonatomic, readwrite) uint16_t version;
@property (nonatomic, readwrite) uint32_t prologueLength;
@property (nonatomic, readwrite) uint8_t minimumInstructionLength;
@property (nonatomic, readwrite) BOOL defaultIsStatement;
@property (nonatomic, readwrite) int8_t lineBase;
@property (nonatomic, readwrite) uint8_t lineRange;
@property (nonatomic, readwrite) uint8_t opcodeBase;

@property (nonatomic, retain, readwrite) Dwarf2Buffer *programBuffer;
@property (nonatomic, readwrite) int32_t programLength;

- (void)readIncludeDirectoriesFromBuffer:(Dwarf2Buffer *)buffer;

- (void)readFileEntriesFromBuffer:(Dwarf2Buffer *)buffer;

- (void)readStandardOpcodeLengthsFromBuffer:(Dwarf2Buffer *)buffer;

- (void)readPrologueFromBuffer:(Dwarf2Buffer *)buffer;

@end

@implementation Dwarf2StatementProgram {
@private
    NSMutableArray *_includeDirectories;
    NSMutableArray *_files;
}

@synthesize totalLength = _totalLength;
@synthesize version = _version;
@synthesize prologueLength = _prologueLength;
@synthesize minimumInstructionLength = _minimumInstructionLength;
@synthesize defaultIsStatement = _defaultIsStatement;
@synthesize lineBase = _lineBase;
@synthesize lineRange = _lineRange;
@synthesize opcodeBase = _opcodeBase;
@synthesize programBuffer = _programBuffer;
@synthesize programLength = _programLength;

- (id)initWithBuffer:(Dwarf2Buffer *)buffer
{
    self = [super init];
    if (self) {
        _includeDirectories = [[NSMutableArray alloc] initWithCapacity:10];
        _files = [[NSMutableArray alloc] initWithCapacity:10];
        
        [self readPrologueFromBuffer:buffer];
        
        self.programBuffer = [buffer getSubBufferOfSize:self.programLength];
    }
    
    return self;
}

- (void)dealloc
{
    [_includeDirectories release];
    [_files release];
    [super dealloc];
}

- (void)addIncludeDirectory:(NSString *)directory
{
    [_includeDirectories addObject:directory];
}

- (void)addFile:(Dwarf2FileEntry *)file
{
    [_files addObject:file];
}

- (void)readIncludeDirectoriesFromBuffer:(Dwarf2Buffer *)buffer
{
    @autoreleasepool {
        NSString *includePath = [buffer getString];
        while (includePath.length > 0) {
            [self addIncludeDirectory:includePath];
            includePath = [buffer getString];
        }        
    }
}

- (void)readFileEntriesFromBuffer:(Dwarf2Buffer *)buffer
{
    @autoreleasepool {
        NSString *filename = [buffer getString];
        while (filename.length > 0) {
            Dwarf2FileEntry *fileEntry = [[Dwarf2FileEntry alloc] init];
            fileEntry.filename = filename;
            fileEntry.directoryIndex = [buffer getULeb128];
            fileEntry.lastModified = [buffer getULeb128];
            fileEntry.length = [buffer getULeb128];
            [self addFile:fileEntry];
            filename = [buffer getString];
        }
    }
}

- (void)readStandardOpcodeLengthsFromBuffer:(Dwarf2Buffer *)buffer
{
    
}

- (void)readPrologueFromBuffer:(Dwarf2Buffer *)buffer
{
    
}

@end
