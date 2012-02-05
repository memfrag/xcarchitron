//
//  Dwarf2Buffer.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2Buffer.h"

@interface Dwarf2Buffer () {
@private
    uint8_t *base;
    uint32_t position;
}

@property (nonatomic, readonly) uint8_t *cursor;

@end

@implementation Dwarf2Buffer

@synthesize size = _size;

- (id)initWithBasePointer:(uint8_t *)basePointer ofSize:(uint32_t)size
{
    self = [super init];
    if (self) {
        _size = size;
        base = basePointer;
        position = 0;
    }
    
    return self;
}

- (void)setPosition:(uint32_t)newPosition
{
    if (position < _size) {
        position = newPosition;
        return;
    }
    
    // Out of bounds error
    BREAKPOINT;
}

- (uint32_t)position
{
    return position;
}

- (uint8_t *)cursor
{
    return base + position;
}

- (BOOL)hasMoreData
{
    return position < _size;
}

- (uint32_t)peekUWord
{
    return *(uint32_t *)self.cursor;
}

- (uint32_t)getUWord
{
    uint32_t value; // = *(uint32_t *)self.cursor;
    memcpy(&value, self.cursor, sizeof(uint32_t));
    self.position += sizeof(uint32_t);
    return value;
}

- (uint64_t)getUWord64
{
    uint64_t value; // = *(uint64_t *)self.cursor;
    memcpy(&value, self.cursor, sizeof(uint64_t));
    self.position += sizeof(uint64_t);
    return value;
}

- (uint16_t)getUHalf
{
    uint16_t value; // = *(uint16_t *)self.cursor;
    memcpy(&value, self.cursor, sizeof(uint16_t));
    self.position += sizeof(uint16_t);
    return value;
}

- (uint8_t)getUByte
{
    uint8_t value = *(uint8_t *)self.cursor;
    self.position += sizeof(uint8_t);
    return value;
}

- (int8_t)getSByte
{
    int8_t value = *(int8_t *)self.cursor;
    memcpy(&value, self.cursor, sizeof(uint32_t));
    self.position += sizeof(int8_t);
    return value;
}

- (BOOL)getBoolean
{
    return [self getUByte] != 0;
}

- (uint32_t)getAddress
{
    uint32_t value; // = *(uint32_t *)self.cursor;
    memcpy(&value, self.cursor, sizeof(uint32_t));
    self.position += sizeof(uint32_t);
    return value;
}

- (NSString *)getString
{
    NSString *str = [NSString stringWithCString:(char *)self.cursor encoding:NSUTF8StringEncoding];
    self.position += str.length + 1;
    return str;
}

- (uint8_t *)getBytes:(uint32_t)byteCount;
{
    uint8_t *ptr = self.cursor;
    self.position += byteCount;
    return ptr;
}

- (uint32_t)getULeb128
{
    uint32_t val = 0;
    uint8_t b;
    int shift = 0;
    
    while (YES) {
        b = [self getUByte];
        val |= (b & 0x7f) << shift;
        if ((b & 0x80) == 0) {
            break;
        }
        shift += 7;
    }
    
    return val;
}

- (int32_t)getSLeb128
{
    int32_t val = 0;
    int shift = 0;
    uint8_t b;
    int size = 8 << 3;
    
    while (YES) {
        b = [self getUByte];
        val |= (b & 0x7f) << shift;
        shift += 7;
        if ((b & 0x80) == 0) {
            break;
        }
    }
    
    if (shift < size && (b & 0x40) != 0)
    {
        val |= -(1 << shift);
    }
    
    return val;
}


- (Dwarf2Buffer *)getSubBufferOfSize:(uint32_t)subsize
{
    return [[[Dwarf2Buffer alloc] initWithBasePointer:self.cursor 
                        ofSize:MIN(subsize, (_size - position))] autorelease];
}

@end
