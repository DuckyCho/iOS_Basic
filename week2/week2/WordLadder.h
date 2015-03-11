//
//  WordLadder.h
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordLadder : NSObject
{
    NSString * start;
    NSString * end;
    NSArray * dict;
    NSArray * resultArr;
}
@property NSString * start;
@property NSString * end;
@property NSArray * dict;
@property NSArray * resultArr;
- (id)initWithStartEndWord:(NSString *)inputStart inputEnd:(NSString *)inputEnd inputDict:(NSArray *)inputDict;
- (NSArray *)getResult;
- (NSArray *)work;
- (NSMutableArray *)getChangeAvailableWordsList:(NSString *)word;
- (NSUInteger)countDifferentCharacter:(NSString *)str cmpStr:(NSString *)cmpStr;
@end
