//
//  Dwarf2StatementProgram.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dwarf2Buffer.h"
#import "Dwarf2StateMachineRegisters.h"
#import "Dwarf2FileEntry.h"

@interface Dwarf2StatementProgram : NSObject

// Prologue header fields
@property (nonatomic, readonly) uint32_t totalLength;
@property (nonatomic, readonly) uint16_t version;
@property (nonatomic, readonly) uint32_t prologueLength;
@property (nonatomic, readonly) uint8_t minimumInstructionLength;
@property (nonatomic, readonly) BOOL defaultIsStatement;
@property (nonatomic, readonly) int8_t lineBase;
@property (nonatomic, readonly) uint8_t lineRange;
@property (nonatomic, readonly) uint8_t opcodeBase;
//@property (nonatomic, readonly) uint8_t *standardOpcodeLengths; // Array
//@property (nonatomic, readonly) NSArray *includeDirectories;
//@property (nonatomic, readonly) NSArray *files;

@property (nonatomic, retain, readonly) Dwarf2Buffer *programBuffer;
@property (nonatomic, readonly) int32_t programLength;

//@property (nonatomic, retain) Dwarf2StateMachineRegisters *registersSnapshot;

- (id)initWithBuffer:(Dwarf2Buffer *)buffer;

- (void)addIncludeDirectory:(NSString *)directory;

- (void)addFile:(Dwarf2FileEntry *)file;

@end
