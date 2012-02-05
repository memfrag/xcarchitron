//
//  Dwarf2Abbreviation.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dwarf2Attribute.h"
#import "Dwarf2Buffer.h"

@interface Dwarf2Abbreviation : NSObject

@property (nonatomic, readonly) uint32_t code;
@property (nonatomic, readonly) uint32_t tag;
@property (nonatomic, readonly) BOOL hasChildren;
@property (nonatomic, readonly) NSArray *attributes;

+ (Dwarf2Abbreviation *)abbreviationForCompilationUnitFromSection:(Dwarf2Buffer *)section
                                                           offset:(uint32_t)offset;

- (id)initWithCode:(uint32_t)code tag:(uint32_t)tag hasChildren:(BOOL)hasChildren;

- (void)addAttribute:(Dwarf2Attribute *)attribute;

@end
