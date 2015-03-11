//
//  NXPerson.h
//  week1
//
//  Created by Soony on 2015. 3. 4..
//  Copyright (c) 2015년 YDCho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPerson : NSObject

{
@public
    NSInteger _id;
    NSInteger _age;
    NSString* _name;
    
}

//@property NSString* _name;
-(NXPerson*)initWithName:(NSString*)name age:(int)age;
-(void)setAge:(int)age;
-(NSInteger)getAge;
-(void)setName:(NSString*)name;
-(NSString *)getName;
-(void)display;
@end
