//
//  MEAppDelegate.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEAppDelegate.h"
#import "MEXcodeArchives.h"
#import "MEMainWindowController.h"

@implementation MEAppDelegate {
@private
    MEMainWindowController *mainWindowController;
    MEXcodeArchives *archives;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    archives = [[MEXcodeArchives alloc] init];

    mainWindowController = [[MEMainWindowController alloc] init];
    [mainWindowController showWindow:mainWindowController.window];
    
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [mainWindowController release];
    
    [archives release];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
	return YES;
}

@end
