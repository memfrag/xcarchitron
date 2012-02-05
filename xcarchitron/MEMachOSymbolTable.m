//
//  MEMachOSymbolTable.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMachOSymbolTable.h"
#import "MEMachOSymtabLoadCommand.h"
#import "MEMachOSymbol.h"
#import <mach-o/nlist.h>

@interface MEMachOSymbol (Creation)
+ (MEMachOSymbol *)symbolFromNlist:(struct nlist)nlist stringsPointer:(char *)strings;
@end

@interface MEMachOSymbolTable () {
@private
    NSMutableArray *symbols;
}

- (void)addSymbol:(MEMachOSymbol *)symbol;

@end

@implementation MEMachOSymbolTable

- (id)init
{
    self = [super init];
    if (self) {
        symbols = [[NSMutableArray alloc] initWithCapacity:100];
    }
    
    return self;
}

- (void)dealloc
{
    [symbols release];
    [super dealloc];
}

- (void)addSymbol:(MEMachOSymbol *)symbol
{
    [symbols addObject:symbol];
}

- (NSArray *)symbols
{
    return symbols;
}

+ (MEMachOSymbolTable *)symbolTableFromBasePointer:(void *)base
                                       loadCommand:(MEMachOSymtabLoadCommand *)command
{
    if (base == NULL || command == NULL) {
        return nil;
    }

    MEMachOSymbolTable *symbolTable = [[MEMachOSymbolTable alloc] init];
    
    struct nlist *nlists = (struct nlist *)((uint8_t *)base + command.symbolsFileOffset); 
    char *stringsPointer = (char *)((uint8_t *)base + command.stringsFileOffset);
    
    for (uint32_t i = 0; i < command.symbolCount; i++) {
        MEMachOSymbol *symbol = [MEMachOSymbol symbolFromNlist:nlists[i]
                                                stringsPointer:stringsPointer];
        if (symbol) {
            [symbolTable addSymbol:symbol];
        }
    }
    
    return [symbolTable autorelease];
}

@end
