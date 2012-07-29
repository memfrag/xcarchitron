//
//  Dwarf2CompilationUnit.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "Dwarf2CompilationUnit.h"

@implementation Dwarf2CompilationUnit

@synthesize name = _name;
@synthesize compilationDirectory = _compilationDirectory;
@synthesize statementList = _statementList;

- (void)dealloc
{
    self.name = nil;
    self.compilationDirectory = nil;
    [super dealloc];
}

@end
