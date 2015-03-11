//
//  NXPersonModel.h
//  week2
//
//  Created by Ducky on 2015. 3. 11..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPersonModel : NSObject
{
    NSArray * personList;
}

@property NSArray * personList;

- (id)initWithPersonListPath:(NSString *)path;
- (NSString*)personNameAtIndex:(int)index;
- (NSNumber*)personNumberAtIndex:(int)index;
- (NSNumber*)personTeamAtIndex:(int)index;
- (NSDictionary*)getPersonObjectAtIndex:(int)index;

- (NSString*) findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*) findPersonNumberByName:(NSString*)name;


- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;



@end
