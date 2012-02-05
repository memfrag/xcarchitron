//
//  MEMachOLoadCommand.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEMachOLoadCommand : NSObject

@property (nonatomic, readonly) uint32_t command;
@property (nonatomic, readonly) uint32_t commandSize;

- (id)initWithHeader:(void *)header;

@end
