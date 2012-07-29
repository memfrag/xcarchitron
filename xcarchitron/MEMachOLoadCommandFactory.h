//
//  MEMachOLoadCommandFactory.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEMachOLoadCommand.h"
#import "MEMachOUUIDLoadCommand.h"
#import "MEMachOVersionMinLoadCommand.h"
#import "MEMachOSymtabLoadCommand.h"

@interface MEMachOLoadCommandFactory : NSObject

+ (MEMachOLoadCommand *)loadCommandFromPointer:(void *)pointer;

@end
