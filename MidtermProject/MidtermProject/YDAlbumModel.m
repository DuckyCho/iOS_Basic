//
//  YDAlbumModel.m
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "YDAlbumModel.h"

@implementation YDAlbumModel
@synthesize _data;

- (id)initWithDefaultData{
    if(self =[super init]){
        char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\
        {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\
        {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\
        {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\
        {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\
        {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\
        {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\
        {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\
        {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";
        [self set_defaultData:data];
        NSArray * dataArr = [self parseDefaultData:data];
        [self registerNotificationObserver];
        [self set_data:dataArr];
    }
    return  self;
}

- (void)registerNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sortData:) name:@"sortData" object:nil];
}

- (void)sortData:(NSNotification *)noti{
        [self set_sectionNames:[[NSMutableArray alloc] init]];
        NSArray * sortedArray = [[self _data] sortedArrayUsingComparator:^(id obj1, id obj2) {
            NSString * obj1Date = [(NSDictionary *)obj1 objectForKey:@"date"];
            NSString * obj2Date = [(NSDictionary *)obj2 objectForKey:@"date"];
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMdd"];
            return [[formatter dateFromString:obj1Date] compare:[formatter dateFromString:obj2Date]];
        }];
    NSRange yearRange = NSMakeRange(0, 4);
    NSInteger section = 0;
    NSInteger row = 0;
    NSMutableDictionary * sectionRowMap = [[NSMutableDictionary alloc] init];
    NSString * prevDateYear = [[[sortedArray firstObject] objectForKey:@"date"] substringWithRange:yearRange];
    NSString * curDateYear;
    for(id obj in sortedArray){
        curDateYear = [[(NSDictionary *)obj objectForKey:@"date"] substringWithRange:yearRange];
        if(![prevDateYear isEqualToString:curDateYear]){
            [sectionRowMap setObject:[NSNumber numberWithInteger:row] forKey:[NSNumber numberWithInteger:section]];
            [[self _sectionNames] addObject:prevDateYear];
            section = section + 1;
            row = 1;
        }
        else{
            row = row + 1;
        }
        prevDateYear = curDateYear;
    }
    [sectionRowMap setObject:[NSNumber numberWithInteger:row] forKey:[NSNumber numberWithInteger:section]];
    [[self _sectionNames] addObject:curDateYear];
    [self set_data:sortedArray];
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:[NSNumber numberWithInteger:[sectionRowMap count]] forKey:@"numberOfSectionsInTableView"];
    [userInfo setObject:[NSNumber numberWithInteger:[sortedArray count]] forKey:@"numberOfRowsInSection"];
    [userInfo setObject:sectionRowMap forKey:@"sectionRowMap"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataReady" object:nil userInfo:userInfo];
}

- (NSArray *)parseDefaultData:(char *)data{
    NSArray * result;
    NSData * dataConverted = [NSData dataWithBytes:data length:strlen(data)];
    NSObject * obj = [NSJSONSerialization JSONObjectWithData:dataConverted options:NSJSONReadingMutableContainers error:nil];
    if([obj isKindOfClass:[NSArray class]]){
        result = (NSArray *)obj;
    }
    NSMutableDictionary * userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:[NSNumber numberWithInt:1] forKey:@"numberOfSectionsInTableView"];
    [userInfo setObject:[NSNumber numberWithInteger:[result count]] forKey:@"numberOfRowsInSection"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dataReady" object:nil userInfo:userInfo];
    return result;
}

- (void)resetData{
    [self set_data:[self parseDefaultData:[self _defaultData]]];
}

- (NSDictionary *)getData:(NSInteger)row{
    return [[self _data] objectAtIndex:row];
}

- (void)deleteData:(NSInteger)idx{
    NSMutableArray * newData = [[NSMutableArray alloc]initWithArray:[self _data]];
    [newData removeObjectAtIndex:idx];
    [self set_data:newData];
    
}

- (NSString *)getSectionName:(NSInteger)section{
    return [[self _sectionNames] objectAtIndex:section];
    
}

@end
