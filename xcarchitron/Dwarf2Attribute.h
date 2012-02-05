//
//  Dwarf2Attribute.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2Attribute : NSObject

@property (nonatomic, readonly) uint32_t name;
@property (nonatomic, readonly) uint32_t form;

- (id)initWithName:(uint32_t)name form:(uint32_t)form;

@end


