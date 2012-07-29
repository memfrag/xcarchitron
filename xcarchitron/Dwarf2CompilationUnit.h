//
//  Dwarf2CompilationUnit.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dwarf2CompilationUnit : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *compilationDirectory;
@property (nonatomic, assign) uint32_t statementList;

@end
