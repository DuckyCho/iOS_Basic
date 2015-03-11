//
//  WordLadder.m
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "WordLadder.h"

@implementation WordLadder
@synthesize start, end, dict, resultArr;
- (id)initWithStartEndWord:(NSString *)inputStart inputEnd:(NSString *)inputEnd inputDict:(NSArray *)inputDict{
    if(self = [super init]){
        [self setStart:inputStart];
        [self setEnd:inputEnd];
        [self setDict:inputDict];
    }
    return self;
}
- (NSArray *)getResult{
    [self setResultArr: [self work]];
    return [self resultArr];
}

- (NSArray *)work{
    NSMutableDictionary * changeAvailableWordsDict = [[NSMutableDictionary alloc]init];
    NSMutableArray * resultBuffer = [[NSMutableArray alloc]init];
    NSMutableArray * tmpResult = [[NSMutableArray alloc]init];
    NSString * curWord = [self start];
    NSMutableArray * changeAvailableWordsArr;
    
    while(![curWord isEqualToString:[self end]]){
        if(![changeAvailableWordsDict objectForKey:curWord]){
            changeAvailableWordsArr = [self getChangeAvailableWordsList:curWord];
            [changeAvailableWordsArr addObject:[NSNumber numberWithInt:-1]];
            [changeAvailableWordsArr addObject:[NSNumber numberWithInt:0]];
            [changeAvailableWordsDict setObject:changeAvailableWordsArr forKey:curWord];
        }
        changeAvailableWordsArr = [changeAvailableWordsDict objectForKey:curWord];
        NSNumber * idx = [changeAvailableWordsArr objectAtIndex:[changeAvailableWordsArr count]-2];
        idx = [NSNumber numberWithInt:[idx intValue] + 1];
        if([changeAvailableWordsArr lastObject] == [NSNumber numberWithInt:1] ||
           [idx intValue] >= [changeAvailableWordsArr count]-2){
            curWord = [resultBuffer lastObject];
            [changeAvailableWordsArr setObject:idx atIndexedSubscript:[changeAvailableWordsArr count]-2];
            continue;
        }
        [resultBuffer addObject:curWord];
        curWord = [changeAvailableWordsArr objectAtIndex:[idx intValue]];
        [changeAvailableWordsArr setObject:idx atIndexedSubscript:[changeAvailableWordsArr count]-2];
        [changeAvailableWordsArr setObject:[NSNumber numberWithInt:1] atIndexedSubscript:[changeAvailableWordsArr count]-1];
        if([self countDifferentCharacter:curWord cmpStr:[self end]] == 1){
            [resultBuffer addObject:curWord];
            curWord = [self end];
        }
    }
    [tmpResult addObject:resultBuffer];
    
    [self setResultArr:tmpResult];
    return [self resultArr];
}

- (NSMutableArray *)getChangeAvailableWordsList:(NSString *)word{
    NSMutableArray * changeAvailableWordsArr = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < [[self dict] count] ; i++){
        if([self countDifferentCharacter:word cmpStr:[[self dict] objectAtIndex:i]] == 1){
            [changeAvailableWordsArr addObject:[[self dict]objectAtIndex:i]];
        }
    }
    return changeAvailableWordsArr;
}

- (NSUInteger)countDifferentCharacter:(NSString *)str cmpStr:(NSString *)cmpStr{
    if([str length] != [cmpStr length]){
        return -1;
    }
    else{
        int differCount = 0;
        for(int i =0 ; i < [str length] ;i++){
            if([str characterAtIndex:i] != [cmpStr characterAtIndex:i]){
                differCount++;
            }
        }
        return differCount;
    }
}

@end
