//
//  Dwarf2.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2.h"
#import "Dwarf2Constants.h"
#import "Dwarf2Buffer.h"
#import "Dwarf2Abbreviation.h"
#import "Dwarf2CompilationUnit.h"

@interface Dwarf2 () {
@private
    NSMutableArray *compilationUnits;
}

- (NSNumber *)readAddressFromSection:(Dwarf2Buffer *)section
                         pointerSize:(uint8_t)pointerSize;

- (id)readAttributeFromSection:(Dwarf2Buffer *)section
                          form:(uint32_t)form 
                   pointerSize:(uint8_t)pointerSize
                 stringSection:(Dwarf2Buffer *)stringSection;
@end

@implementation Dwarf2

- (void)dealloc
{
    [compilationUnits release];
    [super release];
}

- (void)gatherCompilationUnits
{
    // TODO: Initialize these
    Dwarf2Buffer *infoSection = nil;
    Dwarf2Buffer *abbrevSection = nil;
    Dwarf2Buffer *stringSection = nil;
    
    if (compilationUnits) {
        [compilationUnits release];
        compilationUnits = nil;
    }
    compilationUnits = [[NSMutableArray alloc] initWithCapacity:20];
    
    while (infoSection.hasMoreData) {
        uint32_t length = [infoSection getUWord];
        uint16_t dwarfVersion = [infoSection getUHalf];
        (void)dwarfVersion; // We wont actually use this value
        uint32_t abbrevOffset = [infoSection getUWord];
        uint8_t pointerSize = [infoSection getUByte];
        
        uint32_t dataPosition = infoSection.position;
        
        Dwarf2Abbreviation *abbrevs = [Dwarf2Abbreviation 
                        abbreviationForCompilationUnitFromSection:abbrevSection 
                        offset:abbrevOffset];
        
        uint32_t code = [infoSection getULeb128];
        (void)code; // We won't actually use this value
        
        if (abbrevs.tag == DW_TAG_compile_unit) {
            Dwarf2CompilationUnit *compilationUnit = [[Dwarf2CompilationUnit alloc] init];
            
            @autoreleasepool {
                for (Dwarf2Attribute *attribute in abbrevs.attributes) {
                    id object = [self readAttributeFromSection:infoSection
                                                          form:attribute.form
                                                   pointerSize:pointerSize
                                                 stringSection:stringSection];
                    
                    switch (attribute.name)
                    {
                        case DW_AT_name:
                            compilationUnit.name = (NSString *)object;
                            break;
                        case DW_AT_comp_dir:
                            compilationUnit.compilationDirectory = (NSString *)object;
                            break;
                        case DW_AT_stmt_list:
                            compilationUnit.statementList = [((NSNumber *)object) unsignedIntValue];
                    }
                }
                
                if (compilationUnit.name != nil && compilationUnit.compilationDirectory != nil) {
                    [compilationUnits addObject:compilationUnit];
                }                
            }
            
            [compilationUnit release]; 
            compilationUnit = nil;
        }
        
        // Length + 4 is total size of compilation unit data.
        // 11 is the the size of the compilation unit header.
        infoSection.position = dataPosition + length + 4 - 11;
    }
}


- (id)readAttributeFromSection:(Dwarf2Buffer *)section
                          form:(uint32_t)form 
                   pointerSize:(uint8_t)pointerSize
                 stringSection:(Dwarf2Buffer *)stringSection
{
    id data = nil;
    
    switch (form)
    {
        case DW_FORM_addr:
            data = [self readAddressFromSection:section pointerSize:pointerSize];
            break;
            
        case DW_FORM_ref_addr:
            data = [self readAddressFromSection:section pointerSize:pointerSize];
            break;
            
        case DW_FORM_block:
        {
            uint32_t size = [section getULeb128];
            data = [NSData dataWithBytes:[section getBytes:size] length:size];
        }
            break;
            
        case DW_FORM_block1:
        {
            uint32_t size = (uint32_t)[section getUByte];
            data = [NSData dataWithBytes:[section getBytes:size] length:size];
        }
            break;
            
        case DW_FORM_block2:
        {
            uint32_t size = (uint32_t)[section getUHalf];
            data = [NSData dataWithBytes:[section getBytes:size] length:size];
        }
            break;
            
        case DW_FORM_block4:
        {
            uint32_t size = [section getUWord];
            data = [NSData dataWithBytes:[section getBytes:size] length:size];
        }
            break;
            
        case DW_FORM_data1:
            data = [NSNumber numberWithUnsignedChar:[section getUByte]];
            break;
            
        case DW_FORM_data2:
            data = [NSNumber numberWithUnsignedShort:[section getUHalf]];
            break;
            
        case DW_FORM_data4:
            data = [NSNumber numberWithUnsignedInt:[section getUWord]];
            break;
            
        case DW_FORM_data8:
            data = [NSNumber numberWithUnsignedLongLong:[section getUWord64]];
            break;
            
        case DW_FORM_sdata:
            data = [NSNumber numberWithInt:[section getSLeb128]];
            break;
            
        case DW_FORM_udata:
            data = [NSNumber numberWithUnsignedInt:[section getULeb128]];
            break;
            
        case DW_FORM_string:
            data = [section getString];
            break;
            
        case DW_FORM_flag:
            data = [NSNumber numberWithUnsignedChar:[section getSByte]];
            break;
            
        case DW_FORM_strp: {
                // FIXME: This must get a string from the .debug_str section
                uint32_t stringOffset = [section getUWord];
                stringSection.position = stringOffset;
                data = [stringSection getString];
            }            
            break;
            
        case DW_FORM_ref1:
            data = [NSNumber numberWithUnsignedChar:[section getUByte]];
            break;
            
        case DW_FORM_ref2:
            data = [NSNumber numberWithUnsignedShort:[section getUHalf]];
            break;
            
        case DW_FORM_ref4:
            data = [NSNumber numberWithUnsignedInt:[section getUWord]];
            break;
            
        case DW_FORM_ref8:
            data = [NSNumber numberWithUnsignedLongLong:[section getUWord64]];
            break;
            
        case DW_FORM_ref_udata:
            data = [NSNumber numberWithUnsignedInt:[section getULeb128]];
            break;
            
        case DW_FORM_indirect: {
                uint32_t indirectForm = [section getULeb128];
                data = [self readAttributeFromSection:section
                                                 form:indirectForm
                                          pointerSize:pointerSize
                                        stringSection:stringSection];
            }
            break;
            
        default:
            data = nil;
            break;
    }
    
    return data;
}


- (NSNumber *)readAddressFromSection:(Dwarf2Buffer *)section
                         pointerSize:(uint8_t)pointerSize
{
    uint32_t value;
    
    switch (pointerSize)
    {
        case 2:
            value = [section getUHalf];
        case 4:
            value = [section getAddress];
            //case 8:
            //    value = [section get64BitAddress];
        default:
            value = 0;
            break;
    }
    
    return [NSNumber numberWithUnsignedInt:value];
}

@end
