//
//  WordLadder.m
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "WordLadder.h"
#define NEXT_WORD_IDX 0
#define IS_IN_RESULT_ARR 1
#define NOT_IN_RESULT_ARR 0
#define IN_RESULT_ARR 1

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
    NSMutableDictionary * wordStatusDict = [[NSMutableDictionary alloc]init];
    NSMutableArray * resultBuffer = [[NSMutableArray alloc]init];
    NSMutableArray * tmpResult = [[NSMutableArray alloc]init];
    NSMutableArray * changeAvailableWordsArr;
    NSMutableArray * wordStatus;
    NSNumber * nextWordIdx;
    NSUInteger minLengthResult = [[self dict] count] + 2;
    
    NSString * curWord = [self start];
    [changeAvailableWordsDict setObject:[self getChangeAvailableWordsList:curWord] forKey:curWord];
    [wordStatusDict setObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:IN_RESULT_ARR], nil] forKey:curWord];
    
    [resultBuffer addObject:curWord];
    wordStatus = [wordStatusDict objectForKey:curWord];
    nextWordIdx = [wordStatus objectAtIndex:NEXT_WORD_IDX];
    [wordStatus setObject:[NSNumber numberWithInt:[nextWordIdx intValue]+1] atIndexedSubscript:NEXT_WORD_IDX];
    curWord = [[changeAvailableWordsDict objectForKey:curWord] objectAtIndex:[nextWordIdx intValue]];

    while([resultBuffer count] != 0){
        if(![changeAvailableWordsDict objectForKey:curWord]){
            changeAvailableWordsArr = [self getChangeAvailableWordsList:curWord];
            [changeAvailableWordsDict setObject:changeAvailableWordsArr forKey:curWord];
            [wordStatusDict setObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:NOT_IN_RESULT_ARR], nil] forKey:curWord];
        }
        
        changeAvailableWordsArr = [changeAvailableWordsDict objectForKey:curWord];
        wordStatus = [wordStatusDict objectForKey:curWord];
        nextWordIdx = [wordStatus objectAtIndex:NEXT_WORD_IDX];
        
        if([[wordStatus objectAtIndex:IS_IN_RESULT_ARR] intValue] == IN_RESULT_ARR){
            curWord = [resultBuffer lastObject];
            [resultBuffer removeObject:curWord];
            wordStatus = [wordStatusDict objectForKey:curWord];
            [wordStatus setObject:[NSNumber numberWithInt:NOT_IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
            continue;
        }
        if ([nextWordIdx intValue] >= [changeAvailableWordsArr count]) {
            wordStatus = [wordStatusDict objectForKey:curWord];
            [wordStatus setObject:[NSNumber numberWithInt:NOT_IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
            [wordStatus setObject:[NSNumber numberWithInt:0] atIndexedSubscript:NEXT_WORD_IDX];
            
            curWord = [resultBuffer lastObject];
            [resultBuffer removeObject:curWord];
            wordStatus = [wordStatusDict objectForKey:curWord];
            [wordStatus setObject:[NSNumber numberWithInt:NOT_IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
            continue;
        }
        if([curWord isEqualToString:@"lot"]){
            NSLog(@":");
        }
        [wordStatus setObject:[NSNumber numberWithInt:[nextWordIdx intValue]+1] atIndexedSubscript:NEXT_WORD_IDX];
        [wordStatus setObject:[NSNumber numberWithInt:IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
        [resultBuffer addObject:curWord];
        curWord = [changeAvailableWordsArr objectAtIndex:[nextWordIdx intValue]];
        if([self countDifferentCharacter:curWord cmpStr:[self end]] == 1){
            [resultBuffer addObject:curWord];
            [resultBuffer addObject:[self end]];
            if([resultBuffer count] <= minLengthResult){
                if([resultBuffer count] < minLengthResult){
                    minLengthResult = [resultBuffer count];
                    [tmpResult removeAllObjects];
                }
                [tmpResult addObject:resultBuffer];
            }
            resultBuffer = [[NSMutableArray alloc]initWithArray:resultBuffer];
            //end단어 삭제
            [resultBuffer removeObject:[resultBuffer lastObject]];

            curWord = [resultBuffer lastObject];
            wordStatus = [wordStatusDict objectForKey:curWord];
            [wordStatus setObject:[NSNumber numberWithInt:NOT_IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
            [wordStatus setObject:[NSNumber numberWithInt:0] atIndexedSubscript:NEXT_WORD_IDX];
            [resultBuffer removeObject:curWord];
            
            curWord = [resultBuffer lastObject];
            wordStatus = [wordStatusDict objectForKey:curWord];
            [wordStatus setObject:[NSNumber numberWithInt:NOT_IN_RESULT_ARR] atIndexedSubscript:IS_IN_RESULT_ARR];
            [resultBuffer removeObject:curWord];
            
        }
    }
    
   
    return tmpResult;
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
