//
//  MEMainWindowController.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-05.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEMainWindowController.h"

@implementation MEMainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString *)windowNibName 
{
    return @"MainWindow";
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
