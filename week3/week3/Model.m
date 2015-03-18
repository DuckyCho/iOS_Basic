//
//  Model.m
//  week3
//
//  Created by Ducky on 2015. 3. 18..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "Model.h"

@implementation Model
@synthesize data;
- (id)initWithDataArr:(NSArray *)dataArr{
    if( self =  [super init]){
        self.data = dataArr;
    }
    return self;
}

- (NSDictionary*)itemAtIndex:(int)index{
    return [[self data] objectAtIndex:index];
}
@end
