//
//  MEMachO.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachO.h"
#import "MEMemoryMappedFile.h"
#import "MEMachOSection.h"
#import "MEMachOSymbolTable.h"
#import "MEMachOLoadCommandFactory.h"
#import <mach-o/loader.h>

@interface MEMachOSection (Creation)
+ (MEMachOSection *)sectionFromBasePointer:(void *)base
                                   segment:(NSString *)segmentName
                                   section:(NSString *)sectionName;
@end

@interface MEMachOSymbolTable (Creation)
+ (MEMachOSymbolTable *)symbolTableFromBasePointer:(void *)base
                                       loadCommand:(MEMachOSymtabLoadCommand *)command;
@end

@interface MEMachO () {
    MEMemoryMappedFile *objectFile;
    NSMutableArray *loadCommands;
    MEMachOSymbolTable *symbolTable;
}

- (BOOL)mapObjectFile:(NSURL *)url;

@end

@implementation MEMachO

+ (MEMachO *)machOFromURL:(NSURL *)url
{
    MEMachO *machO = [[MEMachO alloc] init];
    
    if (![machO mapObjectFile:url]) {
        [machO release];
        return nil;
    }
    
    return [machO autorelease];
}

- (void)dealloc
{
    [symbolTable release];
    [loadCommands release];
    [objectFile release];
    [super dealloc];
}

- (BOOL)mapObjectFile:(NSURL *)url
{
    MEMemoryMappedFile *file;
    file = [[MEMemoryMappedFile alloc] initWithPath:[url path]];
    
    void *basePointer = [file map];
    
    if (basePointer == NULL) {
        [file release];
        return NO;
    }
    
    objectFile = file;
    
    return YES;
}

- (MEMachOSection *)findSection:(NSString *)sectionName 
                      inSegment:(NSString *)segmentName
{
    if (objectFile == NULL) {
        return nil;
    }
    
    void *basePointer = [objectFile map];
    
    return [MEMachOSection sectionFromBasePointer:basePointer
                                          segment:segmentName
                                          section:sectionName];
}

- (uint32_t)cpuType
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->cputype;
    }
    return 0;
}

- (uint32_t)cpuSubtype
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->cpusubtype;
    }
    return 0;    
}

- (uint32_t)filetype
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->filetype;
    }
    return 0;
}

- (uint32_t)loadCommandCount
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->ncmds;
    }
    return 0;
}

- (uint32_t)sizeOfAllCommands
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->sizeofcmds;
    }
    return 0;
}

- (uint32_t)flags
{
    struct mach_header *machHeader = (struct mach_header *)[objectFile map];
    if (machHeader != NULL) {
        return machHeader->flags;
    }
    return 0;
}

- (NSArray *)loadCommands
{
    if (loadCommands) {
        return loadCommands;
    }
    
    uint8_t *basePointer = (uint8_t *)[objectFile map];
    if (basePointer == NULL) {
        return nil;
    }
    
    uint32_t commandCount = self.loadCommandCount;
    loadCommands = [[NSMutableArray alloc] initWithCapacity:commandCount]; 
    
    uint8_t *commandPointer = basePointer + sizeof(struct mach_header);
        
    for (uint32_t i = 0; i < commandCount; i++) {
        MEMachOLoadCommand *command;
        command = [MEMachOLoadCommandFactory loadCommandFromPointer:commandPointer];
        
        [loadCommands addObject:command];
        
        commandPointer += command.commandSize;
    }
    
    return loadCommands;
}

- (MEMachOSymbolTable *)symbolTable
{
    if (symbolTable) {
        return symbolTable;
    }
    
    uint8_t *basePointer = (uint8_t *)[objectFile map];
    if (basePointer == NULL) {
        return nil;
    }
    
    for (MEMachOLoadCommand *command in self.loadCommands) {
        if (command.command == LC_SYMTAB) {
            symbolTable = [MEMachOSymbolTable symbolTableFromBasePointer:basePointer
                                    loadCommand:(MEMachOSymtabLoadCommand *)command];
        }
    }
    
    return nil;
}

@end

