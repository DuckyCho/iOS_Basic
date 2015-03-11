//
//  NXPerson.m
//  week1
//
//  Created by Soony on 2015. 3. 4..
//  Copyright (c) 2015년 YDCho. All rights reserved.
//

#import "NXPerson.h"

@implementation NXPerson
//@synthesize _name;

-(NXPerson*)initWithName:(NSString*)name age:(int)age{
    if( self = [super init] ){
        [self setName:name];
        [self setAge:age];
    }
    return self;
}

-(void)display{
    NSLog(@"Name = %@, Age = %lu",_name,_age);
}

-(void)setAge:(int)age{
    _age = age;
}

-(NSInteger)getAge{
    return _age;
}

-(void)setName:(NSString*)name{
    _name = name;
}

-(NSString *)getName{
    return _name;
}

-(NSString*)description{
    NSMutableString * info = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"name : %@ / age : %lu",_name,_age]];
    
    return info;
}

@end
