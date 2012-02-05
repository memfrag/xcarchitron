//
//  MEMachOSymtabLoadCommand.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEMachOLoadCommand.h"

@interface MEMachOSymtabLoadCommand : MEMachOLoadCommand

@property (nonatomic, readonly) uint32_t symbolsFileOffset;
@property (nonatomic, readonly) uint32_t symbolCount;
@property (nonatomic, readonly) uint32_t stringsFileOffset;
@property (nonatomic, readonly) uint32_t stringsSize;

@end
