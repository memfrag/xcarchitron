//
//  MEMachO.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MEMachOSection;
@class MEMachoSymbolTable;

@interface MEMachO : NSObject

@property (nonatomic, readonly) uint32_t cpuType;
@property (nonatomic, readonly) uint32_t cpuSubtype;
@property (nonatomic, readonly) uint32_t filetype;
@property (nonatomic, readonly) uint32_t loadCommandCount;
@property (nonatomic, readonly) uint32_t sizeOfAllCommands;
@property (nonatomic, readonly) uint32_t flags;
@property (nonatomic, readonly) NSArray *loadCommands;
@property (nonatomic, readonly) MEMachoSymbolTable *symbolTable;

+ (MEMachO *)machOFromURL:(NSURL *)url;

- (MEMachOSection *)findSection:(NSString *)sectionName 
                      inSegment:(NSString *)segmentName;

@end
