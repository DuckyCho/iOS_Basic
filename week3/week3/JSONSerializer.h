//
//  JSONSerializer.h
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface JSONSerializer : NSObject

- (NSArray*) MyJSONSerializationFrom:(NSString*)jsonData;
- (NSString*) MyJSONMakerWithArray:(NSArray*)array;
- (NSString*) MyJSONMakerWithDictionary:(NSDictionary*)dictionary;

- (NSObject*)JSONParser:(NSString*)jsonString;
- (NSString*)removeUnnecessaryChar:(NSString*)str;
- (NSMutableArray*)separateWords:(NSString*)str;
- (NSString*)popWord:(NSMutableArray*)arr idx:(NSUInteger)idx;



@end
