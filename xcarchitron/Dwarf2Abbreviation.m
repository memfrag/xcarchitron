//
//  Dwarf2Abbreviation.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2Abbreviation.h"
#import "Dwarf2Constants.h"

@implementation Dwarf2Abbreviation {
@private
    NSMutableArray *_attributes;
}

@synthesize code = _code;
@synthesize tag = _tag;
@synthesize hasChildren = _hasChildren;

- (id)initWithCode:(uint32_t)code tag:(uint32_t)tag hasChildren:(BOOL)hasChildren
{
    self = [super init];
    if (self) {
        _code = code;
        _tag = tag;
        _hasChildren = hasChildren;
        _attributes = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    return nil;
}

- (void)dealloc
{
    [_attributes release];
    [super dealloc];
}

- (NSArray *)attributes
{
    return _attributes;
}

- (void)addAttribute:(Dwarf2Attribute *)attribute
{
    [_attributes addObject:attribute];
}

+ (Dwarf2Abbreviation *)abbreviationForCompilationUnitFromSection:(Dwarf2Buffer *)section
                                                           offset:(uint32_t)offset
{
    section.position = offset;
    
    uint32_t code = [section getULeb128];
    uint32_t tag = [section getULeb128];
    uint8_t hasChildren = [section getUByte];
    
    Dwarf2Abbreviation *abbreviation;
    abbreviation = [[Dwarf2Abbreviation alloc] initWithCode:code
                                                        tag:tag
                                                hasChildren:(hasChildren == DW_CHILDREN_yes)];
    
    uint32_t name = 0;
    uint32_t form = 0;
    
    do {
        name = [section getULeb128];
        form = [section getULeb128];
        
        Dwarf2Attribute *attribute = [[Dwarf2Attribute alloc] initWithName:name
                                                                      form:form];
        if (name != 0 && form != 0) {
            [abbreviation addAttribute:attribute];
            [attribute release];
            attribute = nil;
        }
        
    } while (name != 0 && form != 0);
    
    return [abbreviation autorelease];
}

@end

