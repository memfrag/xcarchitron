//
//  Dwarf2FileEntry.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2FileEntry : NSObject

@property (nonatomic, copy) NSString *filename;
@property (nonatomic, assign) uint32_t directoryIndex;
@property (nonatomic, assign) uint32_t lastModified;
@property (nonatomic, assign) uint32_t length;

@end
