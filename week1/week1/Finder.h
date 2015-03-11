//
//  Finder.h
//  week1
//
//  Created by Soony on 2015. 3. 4..
//  Copyright (c) 2015년 YDCho. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SHALLOW_SEARCH 0
#define DEEP_SEARCH 1

@interface Finder : NSObject

+(void)NXDisplayAllFilesAtPath:(NSString*)path;

+(void)NXDisplayAllFilesAtPathWithFlag:(NSString*)path flag:(NSInteger)flag;

@end
