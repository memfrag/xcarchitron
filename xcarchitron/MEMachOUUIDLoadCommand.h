//
//  MEMachOUUIDLoadCommand.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEMachOLoadCommand.h"

@interface MEMachOUUIDLoadCommand : MEMachOLoadCommand

@property (nonatomic, copy, readonly) NSString *uuid;

@end
