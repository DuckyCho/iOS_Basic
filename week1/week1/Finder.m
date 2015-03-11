//
//  Finder.m
//  week1
//
//  Created by Soony on 2015. 3. 4..
//  Copyright (c) 2015년 YDCho. All rights reserved.
//

#import "Finder.h"

@implementation Finder

+(void)NXDisplayAllFilesAtPath:(NSString*)path{
    NSFileManager* fileManager = [[NSFileManager alloc]init];
    NSDirectoryEnumerator* dirEnum = [fileManager enumeratorAtPath:path];
    for (id obj in dirEnum){
        NSLog(@"%@",obj);
    }
}

+(void)NXDisplayAllFilesAtPathWithFlag:(NSString*)path flag:(NSInteger)flag{
    if (flag == DEEP_SEARCH) {
        [Finder NXDisplayAllFilesAtPath:path];
    }
    else{
        NSFileManager* fileManager = [[NSFileManager alloc]init];
        NSArray* fileList = [[NSArray alloc]initWithArray:[fileManager contentsOfDirectoryAtPath:path error:nil]];
        for (id file in fileList){
            NSLog(@"%@",file);
        }
        
    }
}


@end
