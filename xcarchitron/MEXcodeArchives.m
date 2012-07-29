//
//  MEXcodeArchives.m
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import "MEXcodeArchives.h"
#import "MEXcodeArchive.h"

@interface MEXcodeArchives ()

@property (nonatomic, retain, readwrite) NSArray *archives;

@property (nonatomic, retain, readwrite) NSDictionary *archivesByBundleId;

- (void)gatherArchives;

@end

@implementation MEXcodeArchives

@synthesize archives = _archives;
@synthesize archivesByBundleId = _archivesByBundleId;

- (id)init
{
    self = [super init];
    if (self) {
        [self gatherArchives];
    }
    
    return self;
}

- (void)dealloc
{
    self.archives = nil;
    [super dealloc];
}

- (void)gatherArchives
{
    NSString *archivesPath = [@"~/Library/Developer/Xcode/Archives/" stringByExpandingTildeInPath];
    NSURL *archivesUrl = [NSURL URLWithString:archivesPath];
    
    NSFileManager *localFileManager = [[NSFileManager alloc] init];
    
    NSDirectoryEnumerator *dirEnumerator = [localFileManager enumeratorAtURL:archivesUrl
                                                  includingPropertiesForKeys:[NSArray arrayWithObject:NSURLNameKey]
                                                                     options:NSDirectoryEnumerationSkipsPackageDescendants
                                                                errorHandler:nil];
    
    NSMutableArray *archives = [NSMutableArray arrayWithCapacity:10];
    NSMutableDictionary *archivesByBundleId = [NSMutableDictionary dictionaryWithCapacity:10];
    
    for (NSURL *archiveUrl in dirEnumerator)
    {
        // Retrieve the file name. From NSURLNameKey, cached during the enumeration.
        NSString *fileName;
        [archiveUrl getResourceValue:&fileName forKey:NSURLNameKey error:NULL];
        
        if ([fileName hasSuffix:@".xcarchive"])
        {
            NSURL *infoPlistUrl = [archiveUrl URLByAppendingPathComponent:@"/Info.plist"];
            if ([infoPlistUrl checkResourceIsReachableAndReturnError:nil]) {
                MEXcodeArchive *archive = [[[MEXcodeArchive alloc] initWithURL:archiveUrl] autorelease];
                [archives addObject:archive];
                
                NSMutableArray *bundleArchives = [archivesByBundleId objectForKey:archive.bundleIdentifier];
                if (bundleArchives == nil) {
                    bundleArchives = [NSMutableArray arrayWithCapacity:10];
                    [archivesByBundleId setObject:bundleArchives forKey:archive.bundleIdentifier];
                }
                [bundleArchives addObject:archive];
                
                
                NSLog(@"------------------------------------------");
                NSLog(@" - URL: %@", archive.url);
                NSLog(@" - Name: %@", archive.name);
                NSLog(@" - App URL: %@", archive.appBundleURL);
                NSLog(@" - Icon: %@", archive.icon);
                NSLog(@" - Creation Date: %@", archive.creationDate);
                NSLog(@" - Comment: %@", archive.comment);
                NSLog(@" - Bundle Identifier: %@", archive.bundleIdentifier);
                NSLog(@" - Version: %@", archive.version);
                NSLog(@" - Scheme Name: %@", archive.schemeName);
                NSLog(@" - Executable URL: %@", archive.executableURL);
                NSLog(@" - Provisioning Profile: %@", archive.provisioningProfile);
                NSLog(@"    - Name: %@", archive.provisioningProfile.name);
                NSLog(@"    - App Identifier Prefix: %@", archive.provisioningProfile.appIdentifierPrefix);
                NSLog(@"    - App Identifier: %@", archive.provisioningProfile.appIdentifier);
                NSLog(@"    - Creation Date: %@", archive.provisioningProfile.creationDate);
                NSLog(@"    - Expiration Date: %@", archive.provisioningProfile.expirationDate);
                NSLog(@"    - Provisioned Devices: %@", archive.provisioningProfile.provisionedDevices);
                NSLog(@"    - Time to Live: %@", archive.provisioningProfile.timeToLive);
                NSLog(@"    - UUID: %@", archive.provisioningProfile.uuid);
                
            }
        }
    }
    
    // Release the localFileManager.
    [localFileManager release];
    
    self.archives = archives;
    self.archivesByBundleId = archivesByBundleId;
}

@end