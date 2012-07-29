//
//  MEMachOSymbol.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOSymbol.h"
#import <mach-o/nlist.h>

@interface MEMachOSymbol ()

@property (nonatomic, copy, readwrite) NSString *symbolName;
@property (nonatomic, readwrite) uint8_t typeFlags;
@property (nonatomic, readwrite) uint8_t sectionIndex;
@property (nonatomic, readwrite) uint16_t descriptionFlags;
@property (nonatomic, readwrite) uint32_t value;

@end

@implementation MEMachOSymbol

@synthesize symbolName = _symbolName;
@synthesize typeFlags = _typeFlags;
@synthesize sectionIndex = _sectionIndex;
@synthesize descriptionFlags = _descriptionFlags;
@synthesize value = _value;

- (void)dealloc
{
    self.symbolName = nil;
    [super dealloc];
}

+ (MEMachOSymbol *)symbolFromNlist:(struct nlist)nlist stringsPointer:(char *)strings
{
    if (strings == NULL) {
        return nil;
    }
    
    MEMachOSymbol *symbol = [[MEMachOSymbol alloc] init];
    
    symbol.symbolName = [NSString stringWithCString:(strings + nlist.n_un.n_strx) encoding:NSUTF8StringEncoding];
    symbol.typeFlags = nlist.n_type;
    symbol.sectionIndex = nlist.n_sect;
    symbol.descriptionFlags = nlist.n_desc;
    symbol.value = nlist.n_value;
    
    return symbol;
}

@end
