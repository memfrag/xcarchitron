//
//  Dwarf2StateMachineRegisters.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2StateMachineRegisters.h"

@interface Dwarf2StateMachineRegisters ()
@property (nonatomic, readwrite) uint32_t baseAddress;
@end

@implementation Dwarf2StateMachineRegisters {
    uint32_t _address;
}

@synthesize file = _file;
@synthesize line = _line;
@synthesize column = _column;
@synthesize isStatement = _isStatement;
@synthesize isBasicBlock = _isBasicBlock;
@synthesize isEndSequence = _isEndSequence;
@synthesize baseAddress = _baseAddress;

- (id)initWithDefaultValueForIsStatement:(BOOL)defaultIsStatement
{
    self = [super init];
    if (self) {
        [self resetWithDefaultValueForIsStatement:defaultIsStatement];
    }
    
    return self;
}

- (void)resetWithDefaultValueForIsStatement:(BOOL)defaultIsStatement
{
    _address = 0;
    _file = 1;
    _line = 1;
    _column = 0;
    _isStatement = defaultIsStatement;
    _isBasicBlock = NO;
    _isEndSequence = NO;
}

- (Dwarf2StateMachineRegisters *)snapshot
{
    Dwarf2StateMachineRegisters *snapshot = [[Dwarf2StateMachineRegisters alloc] init];
    snapshot.address = self.address;
    snapshot.file = self.file;
    snapshot.line = self.line;
    snapshot.column = self.column;
    snapshot.isStatement = self.isStatement;
    snapshot.isBasicBlock = self.isBasicBlock;
    snapshot.isEndSequence = self.isEndSequence;
    snapshot.baseAddress = self.baseAddress;
    
    return [snapshot autorelease];
}

- (uint32_t)address
{
    return _address;
}

- (void)setAddress:(uint32_t)address
{
    _address = address;
    _baseAddress = address;
}

- (void)toggleIsStatement
{
    self.isStatement = !self.isStatement;
}

@end
