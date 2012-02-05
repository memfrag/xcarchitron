//
//  MEMachOVersionMinLoadCommand.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEMachOLoadCommand.h"

@interface MEMachOVersionMinLoadCommand : MEMachOLoadCommand

@property (nonatomic, readonly) uint32_t major;
@property (nonatomic, readonly) uint32_t minor;
@property (nonatomic, readonly) uint32_t revision;

@end