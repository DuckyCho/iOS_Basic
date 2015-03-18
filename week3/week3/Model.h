//
//  Model.h
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
{
    NSArray * data;
}

@property NSArray * data;
- (id)initWithDataArr:(NSArray *)dataArr;
- (NSDictionary*)itemAtIndex:(int)index;
@end
