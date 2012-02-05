//
//  MEXcodeArchives.h
//  xcarchitron
//
//  Created by Martin Johannesson on 2012-02-04.
//  Copyright (c) 2012 Martin Johannesson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEXcodeArchives : NSObject

@property (nonatomic, retain, readonly) NSArray *archives;

@property (nonatomic, retain, readonly) NSDictionary *archivesByBundleId;

@end
