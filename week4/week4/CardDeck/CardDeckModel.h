//
//  CardDeckModel.h
//  week4
//
//  Created by Ducky on 2015. 3. 25..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDeckModel : NSObject
- (id)initWithRandomSeed;
- (void)randomize;
@end
