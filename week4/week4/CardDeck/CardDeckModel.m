//
//  CardDeckModel.m
//  week4
//
//  Created by Ducky on 2015. 3. 25..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import "CardDeckModel.h"

@implementation CardDeckModel

- (id)initWithRandomSeed{
    if(self = [super init]){
    srand((unsigned)time(NULL));
    }
    return self;
}

- (void)randomize{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cardPick" object:nil userInfo:@{@"cardNum":[[NSNumber alloc]initWithInt: rand()%52]}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@ %@",object, change);
}
@end
