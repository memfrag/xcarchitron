//
//  Dwarf2Attribute.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2Attribute.h"

@implementation Dwarf2Attribute

@synthesize name = _name;
@synthesize form = _form;

- (id)initWithName:(uint32_t)name form:(uint32_t)form
{
    self = [super init];
    if (self) {
        _name = name;
        _form = form;
    }
    
    return self;
}

@end
