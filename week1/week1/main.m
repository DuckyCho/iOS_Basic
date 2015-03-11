//
//  main.m
//  week1
//
//  Created by Soony on 2015. 3. 4..
//  Copyright (c) 2015년 YDCho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPerson.h"
#import "Finder.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NXPerson* person = [[NXPerson alloc]initWithName:@"조영대" age:28];
//        NSLog(@"%@",person);
//        [person display];
//        NSLog(@"Hello, World!");
        
//        Finder * finder = [[Finder alloc]init];
//        [Finder NXDisplayAllFilesAtPath:@"/Users/choducky/Desktop/iOS_basic/iOS_Basic/week1"];
//        
        [Finder NXDisplayAllFilesAtPathWithFlag:@"/Users/choducky/Desktop/iOS_basic/iOS_Basic/week1" flag:DEEP_SEARCH];
    }
    return 0;
}
