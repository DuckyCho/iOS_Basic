//
//  YDAlbumModel.h
//  Midterm
//
//  Created by Ducky on 2015. 4. 15..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDAlbumModel : NSObject

@property (nonatomic) char * _defaultData;
@property (nonatomic) NSArray * _data;

@property (nonatomic) NSMutableArray * _sectionNames;

- (id)initWithDefaultData;
- (NSDictionary *)getData:(NSInteger)row;
- (void)resetData;
- (void)deleteData:(NSInteger)idx;
- (NSString *)getSectionName:(NSInteger)section;
@end
