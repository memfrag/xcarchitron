//
//  Dwarf2Buffer.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2Buffer : NSObject

@property (nonatomic, assign) uint32_t position;
@property (nonatomic, readonly) uint32_t size;
@property (nonatomic, readonly) BOOL hasMoreData;

- (id)initWithBasePointer:(uint8_t *)basePointer ofSize:(uint32_t)size;

- (uint32_t)peekUWord;
- (uint32_t)getUWord;
- (uint64_t)getUWord64;
- (uint16_t)getUHalf;
- (uint8_t)getUByte;
- (int8_t)getSByte;
- (BOOL)getBoolean;
- (uint32_t)getAddress;
- (NSString *)getString;
- (uint8_t *)getBytes:(uint32_t)byteCount;
- (uint32_t)getULeb128;
- (int32_t)getSLeb128;
- (Dwarf2Buffer *)getSubBufferOfSize:(uint32_t)subsize;

@end
