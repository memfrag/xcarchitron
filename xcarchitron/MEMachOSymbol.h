//
//  MEMachOSymbol.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEMachOSymbol : NSObject

@property (nonatomic, copy, readonly) NSString *symbolName;
@property (nonatomic, readonly) uint8_t typeFlags;
@property (nonatomic, readonly) uint8_t sectionIndex;
@property (nonatomic, readonly) uint16_t descriptionFlags;
@property (nonatomic, readonly) uint32_t value;

@end
