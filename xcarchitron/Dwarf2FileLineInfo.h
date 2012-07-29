//
//  Dwarf2FileLineInfo.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2FileLineInfo : NSObject

@property (nonatomic, readonly) uint32_t address;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *filename;
@property (nonatomic, copy, readonly) NSString *fullPath;
@property (nonatomic, readonly) uint32_t line;

- (id)initWithAddress:(uint32_t)address
                 path:(NSString *)path
             filename:(NSString *)filename
                 line:(uint32_t)line;

@end
