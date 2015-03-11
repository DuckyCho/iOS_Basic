//
//  NXPersonModel.m
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "NXPersonModel.h"
@implementation NXPersonModel
@synthesize personList;
- (id)initWithPersonListPath:(NSString *)path{
        if(self = [super init]){
            NSString * listStr = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            if(!listStr){
                return self;
            }
            NSMutableArray * listArr = [[NSMutableArray alloc] init];
            NSArray * listLineArr = [listStr componentsSeparatedByString:@"\n"];
            for(int i = 0 ; i < listLineArr.count ; i++){
                NSArray * tmp = [listLineArr[i] componentsSeparatedByString:@","];
                NSDictionary * person = [[NSDictionary alloc]initWithObjects:tmp forKeys:[NSArray arrayWithObjects:@"name",@"id",@"teamNum",nil]];
                [listArr addObject:person];
            }
            [self setPersonList:listArr];
        }
        return self;
    }
- (NSString*)personNameAtIndex:(int)index{
    return [[[self personList]objectAtIndex:index]valueForKey:@"name"];
}
- (NSNumber*)personNumberAtIndex:(int)index{
    return [[[self personList]objectAtIndex:index]valueForKey:@"id"];
}
- (NSNumber*)personTeamAtIndex:(int)index{
    return [[[self personList]objectAtIndex:index]valueForKey:@"teamNum"];
}
- (NSDictionary*)getPersonObjectAtIndex:(int)index{
        return [[self personList]objectAtIndex:index];
}
- (NSString*) findPersonNameByNumber:(NSNumber*)number{
    NSString * person;
    for(int i = 0 ; i < [self personList].count ; i++){
        person = [[self personList]objectAtIndex:i];
        if([[person valueForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%@",number]]){
            break;
        }
    }
    return [person valueForKey:@"name"];
}
- (NSNumber*) findPersonNumberByName:(NSString*)name{
    NSString * person;
    for(int i = 0 ; i < [self personList].count ; i++){
        person = [[self personList]objectAtIndex:i];
        if([[person valueForKey:@"name"] isEqualToString:name]){
            break;
        }
    }
    return [NSNumber numberWithInteger:[[person valueForKey:@"id"] integerValue]];
}

- (NSArray*) sortedByName{
    return [[self personList] sortedArrayUsingFunction: objSort context:@"name"];
}

- (NSArray*) sortedByNumber{
    return [[self personList] sortedArrayUsingFunction: objSort context:@"id"];
}

- (NSArray*) sortedByTeam{
    return [[self personList] sortedArrayUsingFunction: objSort context:@"teamNum"];
}


NSInteger objSort(id obj1, id obj2, void *context){
    NSString * key = (__bridge NSString *)(context);
    NSString * obj1str = [obj1 valueForKey:key];
    NSString * obj2str = [obj2 valueForKey:key];
    return [obj1str compare:obj2str];
}

@end
