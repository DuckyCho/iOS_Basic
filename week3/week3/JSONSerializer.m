//
//  JSONSerializer.m
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "JSONSerializer.h"

@implementation JSONSerializer

- (NSArray *) MyJSONSerializationFrom : (NSString *)jsonData{
    
    NSRange searchedRange = NSMakeRange(0, [jsonData length]);
    NSString * pattern = @"\"([a-zA-Z0-9]+)\"\\:\\s?\"([a-zA-Z0-9]+)\",\\s?\"([a-zA-Z0-9]+)\"\\s?:\\s?\"([a-zA-Z0-9]+)\"";
    NSError  * error = nil;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    
    NSArray* matches = [regex matchesInString:jsonData options:0 range: searchedRange];
    
    NSMutableDictionary * personDict;
    NSString * key;
    NSString * value;
    NSRange keyRange;
    NSRange valueRange;
    NSMutableArray * resultArr = [[NSMutableArray alloc]init];
    
    for(NSTextCheckingResult * match in matches ){
        personDict = [[NSMutableDictionary alloc]init];
        for(int i = 1 ; i < [match numberOfRanges] ; i++ ){
            keyRange = [match rangeAtIndex:i++];
            valueRange = [match rangeAtIndex:i];
            key = [jsonData substringWithRange:keyRange];
            value = [jsonData substringWithRange:valueRange];
            [personDict setObject:value forKey:key];
        }
        [resultArr addObject:personDict];
    }
    return resultArr;
}

- (NSString*) MyJSONMakerWithArray:(NSArray*)array{
    NSMutableString * resultStr = [[NSMutableString alloc]init];
    for(NSObject * obj in array){
        if([obj isKindOfClass:[NSDictionary class]]){
            NSString * dictStr = [self MyJSONMakerWithDictionary:(NSDictionary *)obj];
            [resultStr appendString:dictStr];
        }
        else{
            [resultStr appendString:[obj description]];
        }
        if([array lastObject] != obj){
            [resultStr appendString:@","];
        }
    }
    [resultStr replaceCharactersInRange:NSMakeRange(0, 0) withString:@"["];
    [resultStr replaceCharactersInRange:NSMakeRange([resultStr length], 0) withString:@"]"];
    NSLog(@"%@",resultStr);
    return resultStr;

}
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary*)dictionary{
    NSMutableString * resultString = [[NSMutableString alloc]init];

    [resultString appendString:@"{"];
    NSUInteger count = [dictionary count];
    NSUInteger i = 1;
    NSEnumerator * enumer = [dictionary keyEnumerator];
    NSString * key;
    while(key = [enumer nextObject]){
        i++;
        [resultString appendString:[NSString stringWithFormat:@"\"%@\":",key]];
        [resultString appendString:[NSString stringWithFormat:@"\"%@\"",[dictionary objectForKey:key]]];
        if(i == count){
            [resultString appendString:@","];
        }
    }
    [resultString appendString:@"}"];
    return resultString;
}


- (NSObject*)JSONParser:(NSString*)jsonString{
    jsonString = [self removeUnnecessaryChar:jsonString];
    NSMutableArray * words = [self separateWords:jsonString];
    NSMutableArray * stack = [[NSMutableArray alloc]init];
    
    NSString * word, * keyStr, * valueStr;
    NSMutableArray * valueArr;
    NSMutableDictionary * valueDict, * tmpDict;
    NSMutableArray * tmpArr;
    id valueObj, obj;
    
    while([words count]!=0){
        word = [self popWord:words idx:0];
        if([word isEqualToString:@"}"]){
            tmpDict = [[NSMutableDictionary alloc] init];
            while(!([(valueObj = [self popWord:stack idx:[stack count]-1]) isKindOfClass:[NSString class]] && [(NSString *)valueObj isEqualToString:@"{"]) ){
                //","을 pop
                if([valueObj isKindOfClass:[NSString class]] && [(NSString *)valueObj isEqualToString:@","]){
                    valueObj = [self popWord:stack idx:[stack count]-1];
                }
                keyStr = [self popWord:stack idx:[stack count]-1];
                if([keyStr isEqualToString:@":"]){
                    keyStr = [self popWord:stack idx:[stack count]-1];
                }
                if([valueObj isKindOfClass:[NSString class]]){
                    valueStr = (NSString *)valueObj;
                    [tmpDict setObject:valueStr forKey:keyStr];
                }
                else if([obj isKindOfClass:[NSArray class]]){
                    valueArr = (NSMutableArray *)valueObj;
                    [tmpDict setObject:valueArr forKey:keyStr];
                }
                else{
                    valueDict = (NSMutableDictionary *)valueObj;
                    [tmpDict setObject:valueDict forKey:keyStr];
                }
            }
            [stack addObject:tmpDict];
            continue;
        }
        else if([word isEqualToString:@"]"]){
            tmpArr =[[NSMutableArray alloc] init];
            while(!([(obj = [self popWord:stack idx:[stack count]-1]) isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@"["] )){
                if([obj isKindOfClass:[NSString class]]){
                    word = (NSString *)obj;
                    if([word isEqualToString:@","]){
                        continue;
                    }
                    [tmpArr addObject:word];
                }
                else if([obj isKindOfClass:[NSArray class]]){
                    valueArr = (NSMutableArray *)obj;
                    [tmpArr addObject:valueArr];
                }
                else{
                    valueDict = (NSMutableDictionary *)obj;
                    [tmpArr addObject:valueDict];
                }
            }
            [stack addObject:tmpArr];
            continue;
        }
        else{
            [stack addObject:word];
        }
    }
    return [stack objectAtIndex:0];
}

- (NSString *)removeUnnecessaryChar:(NSString *)str{
    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

- (NSMutableArray *)separateWords:(NSString *)data{
    NSString * pattern = @"([\\{\\}\\]\\[]|[\\\\a-zA-Z0-9.?가-힣]+|[\\:]|[\\,])";
    NSRange searchedRange = NSMakeRange(0, [data length]);
    NSError  * error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:data options:0 range: searchedRange];
    NSMutableArray * resultArr =[[NSMutableArray alloc]init];
    for(NSTextCheckingResult * match in matches){
        [resultArr addObject:[data substringWithRange:[match rangeAtIndex:0]]];
    }
    return resultArr;
}

- (NSString *)popWord:(NSMutableArray *)arr idx:(NSUInteger)idx{
    NSString * result = [arr objectAtIndex:idx];
    [arr removeObjectAtIndex:idx];
    return result;
}

@end
