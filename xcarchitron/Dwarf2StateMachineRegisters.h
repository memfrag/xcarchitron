//
//  Dwarf2StateMachineRegisters.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2StateMachineRegisters : NSObject

@property (nonatomic, assign) uint32_t address;
@property (nonatomic, assign) uint32_t file;
@property (nonatomic, assign) uint32_t line;
@property (nonatomic, assign) uint32_t column;
@property (nonatomic, assign) BOOL isStatement;
@property (nonatomic, assign) BOOL isBasicBlock;
@property (nonatomic, assign) BOOL isEndSequence;
@property (nonatomic, readonly) uint32_t baseAddress;

- (id)initWithDefaultValueForIsStatement:(BOOL)defaultIsStatement;

- (void)resetWithDefaultValueForIsStatement:(BOOL)defaultIsStatement;

- (Dwarf2StateMachineRegisters *)snapshot;

- (void)toggleIsStatement;

@end
